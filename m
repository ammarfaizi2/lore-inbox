Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268465AbUI2N7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268465AbUI2N7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268458AbUI2N7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:59:04 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:22971 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268446AbUI2N4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:56:40 -0400
Subject: Re: [Patch] Fix oops on rmmod usb-storage
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <415A67B8.2080003@suse.de>
References: <415A67B8.2080003@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Sep 2004 09:56:29 -0400
Message-Id: <1096466196.2028.8.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 03:43, Hannes Reinecke wrote:
> usbcore: deregistering driver usb-storage
> scsi: Device offlined - not ready after error recovery: host 0 channel 0 
> id 0 lun 0
> sr 0:0:0:0: Illegal state transition cancel->offline
> Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1688
>   [<e12bab6e>] scsi_device_set_state+0x9e/0xd0 [scsi_mod]
>   [<e12b8a6e>] scsi_eh_offline_sdevs+0x4e/0x70 [scsi_mod]
>   [<e12b8f1a>] scsi_unjam_host+0x9a/0x1b0 [scsi_mod]
>   [<e12b90f5>] scsi_error_handler+0xc5/0x160 [scsi_mod]
>   [<e12b9030>] scsi_error_handler+0x0/0x160 [scsi_mod]
>   [<c0104255>] kernel_thread_helper+0x5/0x10

This isn't an oops, it's a state transition warning.  Apparently the
customary attempt to cancel the commands failed.  This is really only a
warning and will probably go away eventually (we'll just silently fail
the transition attempt).

> It turned out that in drivers/scsi/hosts.c:scsi_remove_host()
> first the host is removed with scsi_forget_host() and _then_ all 
> outstanding I/O to this host is cancelled with scsi_host_cancel(). 
> Sounds a bit fishy as scsi_host_cancel() tries to talk to a host which 
> we just have deleted ...
> (Incidentally, this is most likely the same bug as Bug #2752 and #3480 
> from bugme.osdl.org :-).
> (And also #133249 from bugzilla.redhat.com :-).
> 
> The attached patch corrects this.
> Please apply.

No, the patch is wrong.  we do forget first to make the host
inaccessible from above then cancel the outstanding commands.

The key to the solution of this problem is to know what USB is trying to
do with the dead device.  SCSI is trying to be polite and explicitly
kill the outstanding commands before it removes the HBA.  Presumably USB
is returning something that says this can't be done so the EH gets all
the way up to offlining.

Also, please at least cc linux-scsi@vger.kernel.org on SCSI problems.

Thanks,

James


