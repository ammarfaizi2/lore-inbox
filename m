Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVBPUmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVBPUmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 15:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVBPUmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 15:42:05 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:20377 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261694AbVBPUlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 15:41:51 -0500
Date: Thu, 17 Feb 2005 02:11:37 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: aeb@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: [util-linux] Enable readprofile output instruction level profiling
Message-ID: <20050216204136.GD4511@impedimenta.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch to the util-linux package that enables readprofile o/p
instruction profiling.  This also helps in determining spinlock contention
in a easy manner, (when CONFIG_FRAME_POINTER is enabled).

This patch is based on an old patch by Tridge for the same purpose.

Example commandline and o/p:
(Second column of the disassembly represents percentage)

# readprofile -m System.map-t -p profile.raw -v -v -k vmlinux-t -l 1000
.
.
     0 __fput                                     0.0000
  1139 fget                                       8.8984
31          2.72        ffffffff8017d890:       sub    $0x28,%rsp
9           0.79        ffffffff8017d894:       mov    %r12,0x18(%rsp)
1           0.09        ffffffff8017d899:       mov    %rbx,0x8(%rsp)
0           0.00        ffffffff8017d89e:       mov    %rbp,0x10(%rsp)
6           0.53        ffffffff8017d8a3:       mov    %r13,0x20(%rsp)
1           0.09        ffffffff8017d8a8:       mov    %edi,%r12d
0           0.00        ffffffff8017d8ab:       mov    %gs:0x0,%rax
76          6.67        ffffffff8017d8b4:       mov    0x5d8(%rax),%rbx
255        22.39        ffffffff8017d8bb:       xor    %ebp,%ebp
0           0.00        ffffffff8017d8bd:       lea    0x4(%rbx),%r13
11          0.97        ffffffff8017d8c1:       mov    %r13,%rdi
8           0.70        ffffffff8017d8c4:       callq  ffffffff8043fb40 <_spin_lock>
447        39.24        ffffffff8017d8c9:       cmp    0x8(%rbx),%r12d
77          6.76        ffffffff8017d8cd:       jae    ffffffff8017d8da <fget+0x4a>
13          1.14        ffffffff8017d8cf:       mov    0x18(%rbx),%rax
7           0.61        ffffffff8017d8d3:       mov    %r12d,%edx
0           0.00        ffffffff8017d8d6:       mov    (%rax,%rdx,8),%rbp
9           0.79        ffffffff8017d8da:       test   %rbp,%rbp
11          0.97        ffffffff8017d8dd:       je     ffffffff8017d8e3
<fget+0x53>
6           0.53        ffffffff8017d8df:       lock incl 0x28(%rbp)
118        10.36        ffffffff8017d8e3:       mov    %r13,%rdi
4           0.35        ffffffff8017d8e6:       callq  ffffffff8043fb70
<_spin_unlock>
39          3.42        ffffffff8017d8eb:       mov    %rbp,%rax
6           0.53        ffffffff8017d8ee:       mov    0x8(%rsp),%rbx
0           0.00        ffffffff8017d8f3:       mov    0x18(%rsp),%r12
0           0.00        ffffffff8017d8f8:       mov    0x10(%rsp),%rbp
4           0.35        ffffffff8017d8fd:       mov    0x20(%rsp),%r13
0           0.00        ffffffff8017d902:       add    $0x28,%rsp


Thanks,
Kiran

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>


--- util-linux-2.12p/sys-utils/readprofile.c	2004-12-11 05:41:09.000000000 +0530
+++ util-linux-2.12p-ppcfix/sys-utils/readprofile.c	2005-02-15 18:15:51.000000000 +0530
@@ -38,6 +38,9 @@
  * 2003-08-12 Nikita Danilov <Nikita@Namesys.COM>
  * - added -s option; example of use:
  * "readprofile -s -m /boot/System.map-test | grep __d_lookup | sort -n -k3"
+ * 2004-02-05  Ravikiran Thiumalai <kiran@in.ibm.com>
+ * - Added instruction profiling support; Use case:
+ * readprofile -m /boot/Sysytem.map-test -v -v -k /boot/vmlinux-test 
  */
 
 #include <errno.h>
@@ -58,7 +61,8 @@
 /* These are the defaults */
 static char defaultmap[]="/boot/System.map";
 static char defaultpro[]="/proc/profile";
-static char optstring[]="M:m:np:itvarVbs";
+static char optstring[]="M:m:np:itvarVbsl:k:";
+static char *kernel_name="vmlinux";
 
 static void *
 xmalloc (size_t size) {
@@ -120,17 +124,68 @@
 		"\t -p <pro-file> (default: \"%s\")\n"
 		"\t -M <mult>     set the profiling multiplier to <mult>\n"
 		"\t -i            print only info about the sampling step\n"
-		"\t -v            print verbose data\n"
+		"\t -v            print verbose data; -v -v for insn profile\n"
 		"\t -a            print all symbols, even if count is 0\n"
 		"\t -b            print individual histogram-bin counts\n"
 		"\t -s            print individual counters within functions\n"
 		"\t -r            reset all the counters (root only)\n"
 		"\t -n            disable byte order auto-detection\n"
-		"\t -V            print version and exit\n"),
+		"\t -V            print version and exit\n"
+		"\t -l <limit>    set limit for disassembly\n"
+		"\t -k <kernel>   set name of kernel image for disassembly\n"),
 		prgname, prgname, defaultmap, boot_uname_r_str(), defaultpro);
 	exit(1);
 }
 
+static FILE *disass_start(char *kernel, unsigned long long start, int size)
+{
+	char cbuf[300];
+	FILE *p;
+	struct stat statbuf;
+	int i;
+
+	if (stat(kernel, &statbuf)) {
+		fprintf(stderr, "failed to stat %s\n", kernel);
+		return NULL;
+	}
+	
+	sprintf(cbuf,
+		"objdump -d --no-show-raw-insn --start-address=0x%llx --stop-address=0x%llx %s",
+		start, start + size, kernel); 
+	p = popen(cbuf, "r");
+	if (!p) {
+		printf("failed to run %s\n", cbuf);
+		return NULL;
+	}
+
+	/* Remove the top 6 lines of objdump blurb */
+	for (i = 1 ; i <= 6 ; i++)
+		if (!fgets(cbuf, sizeof(cbuf) - 1, p)) {
+			fprintf(stderr, 
+				"objdump format incompatiblity or wrong kernel/mapfile combo\n");
+			pclose(p);
+			return NULL;
+		}
+	return p;
+}
+
+static char *disass_next(FILE *p)
+{
+	static char lbuf[200];
+
+	if (!fgets(lbuf, sizeof(lbuf) - 1, p)) 
+		return NULL;
+	if (strncmp(lbuf, "Disassembly", 11) == 0)
+		return NULL;
+
+	return lbuf;
+}
+
+static void disass_close(FILE *p)
+{
+	pclose(p);
+}
+
 int
 main(int argc, char **argv) {
 	FILE *map;
@@ -150,6 +205,7 @@
 	int maplineno=1;
 	int popenMap;   /* flag to tell if popen() has been used */
 	int header_printed;
+	int dumplimit = 0;
 
 #define next (current^1)
 
@@ -166,6 +222,9 @@
 		case 'm':
 			mapFile = optarg;
 			break;
+		case 'k':
+			kernel_name = optarg;
+			break;
 		case 'n':
 			optNative++;
 			break;
@@ -184,9 +243,12 @@
 		case 'i':
 			optInfo++;
 			break;
+		case 'l':
+			dumplimit = atoi(optarg);
+			break;
 		case 'M':
 			mult = optarg;
-			break;
+
 		case 'r':
 			optReset++;
 			break;
@@ -324,6 +386,7 @@
 	 */
 	while (fgets(mapline,S_LEN,map)) {
 		unsigned int this=0;
+		unsigned index0 = indx, end_idx;
 
 		if (sscanf(mapline,"%llx %s %s",&next_add,mode,next_name)!=3) {
 			fprintf(stderr,_("%s: %s(%i): wrong map line\n"),
@@ -345,7 +408,8 @@
 			exit(1);
 		}
 
-		while (indx < (next_add-add0)/step) {
+		end_idx = (next_add - add0) / step + 1;  /* Since buf[0] is step */
+		while (indx < end_idx) {
 			if (optBins && (buf[indx] || optAll)) {
 				if (!header_printed) {
 					printf ("%s:\n", fn_name);
@@ -360,6 +424,45 @@
 		if (optBins) {
 			if (optVerbose || this > 0)
 				printf ("  total\t\t\t\t%u\n", this);
+		} else if (optVerbose >= 2) {
+			fn_len = next_add - fn_add;
+			printf("%6i %-40s %8.4f\n", this, fn_name,
+				this / (double) fn_len);
+			if (this > dumplimit) {
+				FILE *p;
+				char *disass_nxt;
+				p = disass_start(kernel_name, fn_add,
+						((end_idx - index0) * step));
+				if (!p) 
+					exit(1);
+				/* read the first line..shudn't get NULL here */
+				disass_nxt = disass_next(p);
+				indx = index0;
+				while (disass_nxt) {
+					int smpls_insn;
+					char disass_cur[200];
+					unsigned long long disass_next_addr;
+					strncpy(disass_cur, disass_nxt, 200);
+					disass_nxt = disass_next(p);
+					smpls_insn = 0;
+					if (disass_nxt) {
+						sscanf(disass_nxt,"%llx", 
+							&disass_next_addr);
+						while (add0+indx*step < 
+						       disass_next_addr)
+						       smpls_insn += buf[indx++];
+					} else {
+						while (add0+indx*step < 
+						       next_add) 
+						       smpls_insn += buf[indx++];
+					}
+					printf("%d\t%8.2f\t%s",  smpls_insn,
+						100.0 * smpls_insn / this,
+						disass_cur);
+				}
+				disass_close(p);
+				indx = end_idx;
+			}
 		} else if ((this || optAll) &&
 			   (fn_len = next_add-fn_add) != 0) {
 			if (optVerbose)
