Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWGGAIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWGGAIg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWGGAIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:08:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751097AbWGGAIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:08:34 -0400
Date: Thu, 6 Jul 2006 17:11:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, len.brown@intel.com
Subject: Re: Linux v2.6.18-rc1
Message-Id: <20060706171101.20cf7bc1.akpm@osdl.org>
In-Reply-To: <200607061334.57282.s0348365@sms.ed.ac.uk>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	<200607061334.57282.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
>
> On Thursday 06 July 2006 05:26, Linus Torvalds wrote:
> > Ok,
> >  the merge window for 2.6.18 is closed, and -rc1 is out there (git trees
> > updated, the tar-ball and patches are still uploading over my pitiful DSL
> > line - and as usual it may take a short while before mirroring takes
> > place and distributes things across the globe).
> >
> > The changes are too big for the mailing list, even just the shortlog. As
> > usual, lots of stuff happened. Most architectures got updated, ACPI
> > updates, networking, SCSI and sound, IDE, infiniband, input, DVB etc etc
> > etc.
> 
> ACPI problem here. Doesn't seem to actively break anything, but the messages
> look bad (HP NC6000 notebook). Haven't tried suspending. The error popped
> up roughly 90 minutes after booting. Laptop has been on AC power throughout.
> 
> ACPI Error (exmutex-0248): Cannot release Mutex [C0E8], not acquired [20060623]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C044.C057.C0E7.C12F] (Node c1aeca40), AE_AML_MUTEX_NOT_ACQUIRED
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C12F] (Node c1aeecfc), AE_AML_MUTEX_NOT_ACQUIRED
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C137._BST] (Node c1aeec84), AE_AML_MUTEX_NOT_ACQUIRED
> ACPI Exception (acpi_battery-0206): AE_AML_MUTEX_NOT_ACQUIRED, Evaluating _BST [20060623]
> 

I've queued the below for sending via Len.  Whether it is
correct/sufficient I do not know.  The comment from Alexey:

  It seems that there is an error in our code, that either releases ASL
  mutex twice, etc.  In either case the correct behavior seems to not abort
  execution.  Error seems to vanish in 2.6.17, so we should just apply this
  patch.  

is discouraging.



From:  Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

See http://bugme.osdl.org/show_bug.cgi?id=6687
Closes: #50088

patch location:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=202ddb5b6498af53e110f78edd41a217587c1ffb

Signed-off-by: Chuck Short <zulcss@gmail.com>
Signed-off-by: Ben Collins <bcollins@ubuntu.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/executer/exmutex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/executer/exmutex.c~acpi-do-not-abort-method-execution-if-asked-to-release drivers/acpi/executer/exmutex.c
--- a/drivers/acpi/executer/exmutex.c~acpi-do-not-abort-method-execution-if-asked-to-release
+++ a/drivers/acpi/executer/exmutex.c
@@ -246,7 +246,7 @@ acpi_ex_release_mutex(union acpi_operand
 		ACPI_ERROR((AE_INFO,
 			    "Cannot release Mutex [%4.4s], not acquired",
 			    acpi_ut_get_node_name(obj_desc->mutex.node)));
-		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/* Sanity check -- we must have a valid thread ID */
_

