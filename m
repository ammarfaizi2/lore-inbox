Return-Path: <linux-kernel-owner+w=401wt.eu-S1751329AbWLLN0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWLLN0K (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 08:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWLLN0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 08:26:10 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:40373 "EHLO mx1.mandriva.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbWLLN0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 08:26:08 -0500
Date: Tue, 12 Dec 2006 02:17:40 -0200
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][SCSI]: Save some bytes in struct scsi_target
Message-ID: <20061212041740.GD6218@mandriva.com>
References: <20061212031718.GC6218@mandriva.com> <20061212035221.GF21070@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061212035221.GF21070@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 08:52:22PM -0700, Matthew Wilcox wrote:
> On Tue, Dec 12, 2006 at 01:17:18AM -0200, Arnaldo Carvalho de Melo wrote:
> > }; /* size: 368, cachelines: 12 */
> > }; /* size: 364, cachelines: 12 */
> 
> Saving space is always good ;-)
> 
> > -	unsigned int		create:1; /* signal that it needs to be added */
> > +	char			scsi_level;
> > +	unsigned char		create:1; /* signal that it needs to be added */
> >  	unsigned int		pdt_1f_for_no_lun;	/* PDT = 0x1f */
> >  						/* means no lun present */
> >  
> > -	char			scsi_level;
> 
> However, pdt_1f_for_no_lun is really only one bit, saving another 4 bytes.
> 
> >  	struct execute_work	ew;
> >  	enum scsi_target_state	state;
> 
> enums are a bit of a pain.  Even though scsi_target_state uses only two
> values, it's represented as an int.  Unless you're on arm-eabi, when
> it'll use less.  And even then, it won't use less than a byte, as it has
> to be addressable.  I wonder if we can turn scsi_target_state into a
> bit.  That'll save another 8 bytes total.

I guess we could use:

	enum scsi_target_state state:1;

And make the enum entries start with 0 and not 1 as is today, no? With
that we get down to:

}; /* size: 356, cachelines: 12 */
   /* last cacheline: 4 bytes */

Anything else to save these 4 bytes and get down to 11 cachelines per
scsi_target instance? Following patch is on top of the previous one.

Signed-off-by: Arnaldo Carvalho de Melo <acme@mandriva.com>

diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index ab245fc..772f834 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -157,7 +157,7 @@ #define scmd_printk(prefix, scmd, fmt, a
 	dev_printk(prefix, &(scmd)->device->sdev_gendev, fmt, ##a)
 
 enum scsi_target_state {
-	STARGET_RUNNING = 1,
+	STARGET_RUNNING = 0,
 	STARGET_DEL,
 };
 
@@ -176,12 +176,12 @@ struct scsi_target {
 	unsigned int		id; /* target id ... replace
 				     * scsi_device.id eventually */
 	char			scsi_level;
+	enum scsi_target_state	state:1;
 	unsigned char		create:1; /* signal that it needs to be added */
-	unsigned int		pdt_1f_for_no_lun;	/* PDT = 0x1f */
+	unsigned char		pdt_1f_for_no_lun:1;	/* PDT = 0x1f */
 						/* means no lun present */
 
 	struct execute_work	ew;
-	enum scsi_target_state	state;
 	void 			*hostdata; /* available to low-level driver */
 	unsigned long		starget_data[0]; /* for the transport */
 	/* starget_data must be the last element!!!! */
