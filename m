Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUITOZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUITOZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 10:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUITOZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 10:25:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:455 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266603AbUITOZb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 10:25:31 -0400
Date: Mon, 20 Sep 2004 10:02:28 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ingo Freund <Ingo.Freund@e-dict.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: three days running fine, then memory allocation errors
Message-ID: <20040920130228.GB3459@logos.cnet>
References: <NEBBILBHKLDLOMLDGKGNIEKKCIAA.Ingo.Freund@e-dict.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <NEBBILBHKLDLOMLDGKGNIEKKCIAA.Ingo.Freund@e-dict.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Achim, I believe there is a memory leak (maybe several) in gdth's proc handling 
code, can you please take a look at it?

Ingo, can you give the attached patch a test a show us the result 
(you should get "gdth_alloc:x gdth_free:y" on /var/log/messages
at each read of /proc/gdth/xx

On normal server operation just dont "cat /proc/scsi/gdth/.." and your server
should be stable.

On Mon, Sep 20, 2004 at 01:07:54PM +0200, Ingo Freund wrote:
> Hello,
> 
> I hope you guys can help, I cannot use any kernel 2.4 >23 without
> the here described problem.
> 
> Searching the web for solutions to my problem I have already found 
> a thread in a mailing list but no solution was mentioned, also the 
> guys who talked about the error didn't answer to my direct mail.
> 
> The machine is a two xeon cpu database server without any other service 
> except sshd running. I do some tests on the ICP-Vortex GDT controller 
> every 2 minutes by using 
> # cat /proc/scsi/gdt/2
> but the output of cat stops without beeing completed.
> 
> This is what I see in the syslog file every time when I use the cat
> command (the messages beginn after 3 days uptime):
> --> /var/log/messages
> kernel: __alloc_pages: 0-order allocation failed (gfp=0x21/0)
> 
> What do you propose to do for I can get the information I need for 
> longer than three days without reboot? This is a highly used database
> server in production environment.
> 
> Kernel version (from /proc/version):
> Linux version 2.4.27 (root@widbrz01) (gcc version 3.3.1 
> 
> 
> # cat /proc/meminfo 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  2118139904 2074345472 43794432        0 151343104 1742090240
> Swap: 6407458816 48291840 6359166976
> MemTotal:      2068496 kB
> MemFree:         42768 kB
> MemShared:           0 kB
> Buffers:        147796 kB
> Cached:        1694548 kB
> SwapCached:       6712 kB
> Active:         223620 kB
> Inactive:      1709760 kB
> HighTotal:     1179628 kB
> HighFree:         2080 kB
> LowTotal:       888868 kB
> LowFree:         40688 kB
> SwapTotal:     6257284 kB
> SwapFree:      6210124 kB
> 
> # cat /proc/sys/kernel/shmmax 
> 1069547520
> 
> # cat /proc/sys/kernel/shmall 
> 1073741824
> 
> Please let me know if there are any informations you need.
> Thanks in advance for your answer,
> regards
> ingo.
> -- 
> // ---------------------------------------------------------------------
> // e-dict GmbH & Co. KG
> // Ingo Freund         
> // Alter Steinweg 3    
> // D-20459 Hamburg/Germany                E-Mail: Ingo.Freund@e-dict.net
> // ---------------------------------------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gdth.patch"

--- linux-2.4/drivers/scsi/gdth_proc.c.orig	2004-09-20 09:53:51.532561072 -0300
+++ linux-2.4/drivers/scsi/gdth_proc.c	2004-09-20 09:56:43.506417072 -0300
@@ -7,10 +7,12 @@
 #include <linux/completion.h>
 #endif
 
+int gdth_alloc, gdth_free;
+
 int gdth_proc_info(char *buffer,char **start,off_t offset,int length,   
                    int hostno,int inout)
 {
-    int hanum,busnum,i;
+    int hanum,busnum,i, ret = 0;
 
     TRACE2(("gdth_proc_info() length %d ha %d offs %d inout %d\n",
             length,hostno,(int)offset,inout));
@@ -27,8 +29,11 @@
 
     if (inout)
         return(gdth_set_info(buffer,length,i,hanum,busnum));
-    else
-        return(gdth_get_info(buffer,start,offset,length,i,hanum,busnum));
+    else {
+	ret = gdth_get_info(buffer,start,offset,length,i,hanum,busnum);
+	printk(KERN_ERR "gdth_alloc:%d gdth_free:%d\n", gdth_alloc, gdth_free);
+	return ret;
+	}
 }
 
 static int gdth_set_info(char *buffer,int length,int vh,int hanum,int busnum)
@@ -707,6 +712,9 @@
     memset(cmnd, 0xff, 12);
     memset(&gdtcmd, 0, sizeof(gdth_cmd_str));
 
+
+    gdth_alloc = 0; gdth_free = 0;
+
     TRACE2(("gdth_get_info() ha %d bus %d\n",hanum,busnum));
     ha = HADATA(gdth_ctr_tab[hanum]);
 
@@ -1321,6 +1329,7 @@
 #if LINUX_VERSION_CODE >= 0x020322
         ret_val = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 
                                             GDTH_SCRATCH_ORD);
+	gdth_alloc++;
 #else
         ret_val = scsi_init_malloc(GDTH_SCRATCH, GFP_ATOMIC | GFP_DMA);
 #endif
@@ -1343,6 +1352,7 @@
     } else {
 #if LINUX_VERSION_CODE >= 0x020322
         free_pages((unsigned long)buf, GDTH_SCRATCH_ORD);
+	gdth_free++;
 #else
         scsi_init_free((void *)buf, GDTH_SCRATCH);
 #endif

--ibTvN161/egqYuK8--
