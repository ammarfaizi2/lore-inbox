Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVGLJpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVGLJpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVGLJpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:45:32 -0400
Received: from gate.corvil.net ([213.94.219.177]:54543 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261298AbVGLJov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:44:51 -0400
Message-ID: <42D39102.5010503@draigBrady.com>
Date: Tue, 12 Jul 2005 10:44:34 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: How do you accurately determine a process' RAM usage?
References: <42CC2923.2030709@draigBrady.com>	<20050706181623.3729d208.akpm@osdl.org>	<42CCE737.70802@draigBrady.com> <20050707014005.338ea657.akpm@osdl.org>
In-Reply-To: <20050707014005.338ea657.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020305010903000307020302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020305010903000307020302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton wrote:
> OK, please let us know how it goes.

It went very well. I could find no problems at all.
I've updated my script to use the new method, so please merge smaps :)
http://www.pixelbeat.org/scripts/ps_mem.py

Usually the shared mem reported by /proc/$$/statm
is the same as summing all the shared values in in /proc/$$/smaps
but there can be large discrepancies.
In the real world you can see this with a newly started apache.
On my system statm reported that apache was using 35MB,
whereas smaps reported the correct amount of 11MB.
These numbers will converge over time as the unused pages
of the apache processes were swapped out.
Attached is a mem.py script that triggers and reports
the memory discrepancy on an smaps enabled system.

As for the overhead of calling smaps, well comparing to
/proc/$$/maps which does essentially the same thing only
not walking mem, on my 1.6GHz P4, 384MB laptop, gives:

time read_10K_smaps

real    0m3.323s
user    0m0.636s
sys     0m2.660s

time read_10K_maps

real    0m1.742s
user    0m0.300s
sys     0m1.428s

I've also attached a patch to make smaps output match the maps output,
as smaps was not showing info like which map was heap and stack etc.
The code is smaller also, as show_smap() now just calls show_map().
Note this patch is to be applied _after_ Hugh's changes.

-- 
Pádraig Brady - http://www.pixelbeat.org
--

--------------020305010903000307020302
Content-Type: text/x-python;
 name="mem.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mem.py"

#!/usr/bin/python
import os, sys, time
PAGESIZE=os.sysconf("SC_PAGE_SIZE")/1024 #KiB

#stat = {Shared,Rss}
#file = {smaps,statm}
def getMemStat(pid,stat,file):
    if file=="smaps":
        shared_lines=[line
                      for line in open("/proc/"+str(pid)+"/smaps").readlines()
                      if line.find(stat)!=-1]
        return sum([int(line.split()[1]) for line in shared_lines])
    else:
        if stat == "Shared": stat_index=2
        elif stat == "Rss": stat_index=1
        return int(open("/proc/"+str(pid)+"/statm").readline().split()[stat_index])*PAGESIZE

a="\x00"*(32*1024*1024) #alloc 32MiB
pid=os.fork()
if(not pid):
     time.sleep(1)
     sys.exit()

for file in ["statm", "smaps"]:
    rss=float(getMemStat(pid,"Rss",file))
    shr=float(getMemStat(pid,"Shared",file))
    print "/proc/%d/%s reports %.1f%% shared" % (pid,file,((shr/rss)*100))

os.wait()

--------------020305010903000307020302
Content-Type: application/x-texinfo;
 name="linux-2.6.13-rc2-mm1-hd-smaps.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.13-rc2-mm1-hd-smaps.diff"

--- linux-2.6.13-rc2-mm1/fs/proc/task_mmu.c	2005-07-12 06:30:05.000000000 +0000
+++ linux-2.6.13-rc2-mm1-pb/fs/proc/task_mmu.c	2005-07-12 07:29:51.000000000 +0000
@@ -121,9 +121,9 @@
 	 * Print the dentry name for named mappings, and a
 	 * special [heap] marker for the heap:
 	 */
-	if (vma->vm_file) {
+	if (file) {
 		pad_len_spaces(m, len);
-		seq_path(m, file->f_vfsmnt, file->f_dentry, "");
+		seq_path(m, file->f_vfsmnt, file->f_dentry, "\n");
 	} else {
 		if (mm) {
 			if (vma->vm_start <= mm->start_brk &&
@@ -245,32 +245,21 @@
 static int show_smap(struct seq_file *m, void *v)
 {
 	struct vm_area_struct *vma = v;
-	struct file *file = vma->vm_file;
-	int flags = vma->vm_flags;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long vma_len = (vma->vm_end - vma->vm_start);
 	struct mem_size_stats mss;
 
 	memset(&mss, 0, sizeof mss);
 
+	show_map(m, v);
+
 	if (mm) {
 		spin_lock(&mm->page_table_lock);
 		smaps_pgd_range(vma, vma->vm_start, vma->vm_end, &mss);
 		spin_unlock(&mm->page_table_lock);
 	}
 
-	seq_printf(m, "%08lx-%08lx %c%c%c%c ",
-		   vma->vm_start,
-		   vma->vm_end,
-		   flags & VM_READ ? 'r' : '-',
-		   flags & VM_WRITE ? 'w' : '-',
-		   flags & VM_EXEC ? 'x' : '-',
-		   flags & VM_MAYSHARE ? 's' : 'p');
-
-	if (vma->vm_file)
-		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
-
-	seq_printf(m, "\n"
+	seq_printf(m,
 		   "Size:          %8lu KB\n"
 		   "Rss:           %8lu KB\n"
 		   "Shared_Clean:  %8lu KB\n"

--------------020305010903000307020302--
