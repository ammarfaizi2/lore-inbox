Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314959AbSDVXjo>; Mon, 22 Apr 2002 19:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314960AbSDVXjn>; Mon, 22 Apr 2002 19:39:43 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:20754 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314959AbSDVXjm>;
	Mon, 22 Apr 2002 19:39:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] patch to /proc/meminfo to display NUMA stats 
In-Reply-To: Your message of "Mon, 22 Apr 2002 10:05:19 MST."
             <25270000.1019495119@flay> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Apr 2002 09:39:31 +1000
Message-ID: <6087.1019518771@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002 10:05:19 -0700, 
"Martin J. Bligh" <Martin.Bligh@us.ibm.com> wrote:
>Below is a patch to /proc/meminfo to display free, used and total
>memory per node on a NUMA machine. It works fine on an ia32
>machine, but is not yet ready for submission until I make it generic.
>Before I go to the effort of doing that, I thought I'd seek some feedback.
>
>diff -urN virgin-2.4.18/fs/proc/proc_misc.c linux-2.4.18-meminfo/fs/proc/proc_misc.c
>--- virgin-2.4.18/fs/proc/proc_misc.c	Tue Nov 20 21:29:09 2001
>+++ linux-2.4.18-meminfo/fs/proc/proc_misc.c	Mon Apr 15 09:31:32 2002
>+#ifdef CONFIG_NUMA
>+	for (nid = 0; nid < numnodes; ++nid) {
>+		si_meminfo_node(&i, nid);
>+		len += sprintf(page+len, "\n"
>+			"Node %d MemTotal:     %8lu kB\n"
>+			"Node %d MemFree:     %8lu kB\n"
>+			"Node %d MemUsed:     %8lu kB\n"
>+			"Node %d HighTotal:    %8lu kB\n"
>+			"Node %d HighFree:     %8lu kB\n"
>+			"Node %d LowTotal:     %8lu kB\n"
>+			"Node %d LowFree:      %8lu kB\n",
>+			nid, K(i.totalram),
>+			nid, K(i.freeram),
>+			nid, K(i.totalram-i.freeram),
>+			nid, K(i.totalhigh),
>+			nid, K(i.freehigh),
>+			nid, K(i.totalram-i.totalhigh),
>+			nid, K(i.freeram-i.freehigh));
>+	}
>+#endif

meminfo_read_proc() assumes that all its output will fit in one page.
Currently it does, ~520 bytes.  You are adding ~120 bytes per node so
it will break at ~29 nodes using 4K pages.  To make that scalable,
meminfo_read_proc() must be converted to seq_file format.

