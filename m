Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268285AbTAMUKw>; Mon, 13 Jan 2003 15:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268269AbTAMUKw>; Mon, 13 Jan 2003 15:10:52 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:62048 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S268267AbTAMUKs>;
	Mon, 13 Jan 2003 15:10:48 -0500
Date: Mon, 13 Jan 2003 12:16:57 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Paul Rolland <rol@witbe.net>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, rol@as2917.net,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2.5.56] Scsi not compiling without /proc support
Message-ID: <20030113121657.A16667@beaverton.ibm.com>
References: <009001c2ba32$3b4bcdf0$2101a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <009001c2ba32$3b4bcdf0$2101a8c0@witbe>; from rol@witbe.net on Sun, Jan 12, 2003 at 01:00:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 01:00:42PM +0100, Paul Rolland wrote:
> Hello,
> 
> This quick patch is used to remove calls to functions in charge of
> registering/unregistering within /proc when /proc support is not
> enabled.
> 
> Paul Rolland, rol@as2917.net
> 
> diff -uN linux-2.5.56/drivers/scsi/hosts.c
> linux-2.5.56-work/drivers/scsi/hosts.c
> --- linux-2.5.56/drivers/scsi/hosts.c   2003-01-10 21:11:20.000000000
> +0100
> +++ linux-2.5.56-work/drivers/scsi/hosts.c      2003-01-12
> 12:42:59.000000000 +0100
> @@ -345,7 +345,9 @@
>         shost->hostt->present--;
>  
>         /* Cleanup proc */
> +#ifdef CONFIG_PROC_FS
>         scsi_proc_host_rm(shost);
> +#endif
>  
>         kfree(shost);
>  }
> @@ -456,7 +458,9 @@
>  found:
>         spin_unlock(&scsi_host_list_lock);
>  
> +#ifdef CONFIG_PROC_FS
>         scsi_proc_host_add(shost);
> +#endif
>  
>         shost->eh_notify = &sem;
>         kernel_thread((int (*)(void *)) scsi_error_handler, (void *)
> shost, 0);
> 

Paul -

This should really be:

--- 1.54/drivers/scsi/scsi.h	Sat Dec 21 08:54:22 2002
+++ edited/drivers/scsi/scsi.h	Mon Jan 13 11:35:11 2003
@@ -502,8 +502,8 @@
 static inline void scsi_exit_procfs(void) { ; }
 static inline void proc_print_scsidevice(Scsi_Device * sdev, char *buffer, int *size, int len) { ; }
 
-static inline void scsi_proc_host_add(struct Scsi_Host *);
-static inline void scsi_proc_host_rm(struct Scsi_Host *);
+static inline void scsi_proc_host_add(struct Scsi_Host *shost) { ; }
+static inline void scsi_proc_host_rm(struct Scsi_Host *shost) { ; }
 #endif /* CONFIG_PROC_FS */
 
 /*

-- Patrick Mansfield
