Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUCQWzu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 17:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbUCQWzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 17:55:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:45254 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262126AbUCQWzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 17:55:44 -0500
Date: Wed, 17 Mar 2004 14:55:20 -0800
From: Greg KH <greg@kroah.com>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>, akpm@osdl.org, corbet@lwn.net
Cc: Mike Anderson <andmike@us.ibm.com>,
       Matthias Andree <ma+lscsi@dt.e-technik.uni-dortmund.de>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1 SCSI + st regressions (was: Linux 2.6.5-rc1)
Message-ID: <20040317225520.GA4660@kroah.com>
References: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org> <20040316211203.GA3679@merlin.emma.line.org> <20040316211700.GA25059@parcelfarce.linux.theplanet.co.uk> <20040316215659.GA3861@merlin.emma.line.org> <Pine.LNX.4.58.0403172145420.1093@kai.makisara.local> <Pine.LNX.4.58.0403172312410.1093@kai.makisara.local> <20040317214434.GF949@beaverton.ibm.com> <Pine.LNX.4.58.0403180022420.1090@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403180022420.1090@kai.makisara.local>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 12:25:08AM +0200, Kai Makisara wrote:
> On Wed, 17 Mar 2004, Mike Anderson wrote:
> 
> > Kai Makisara [Kai.Makisara@kolumbus.fi] wrote:
> > >  		if (!st_class_member) {
> > >  			printk(KERN_WARNING "st%d: class_simple_device_add failed\n",
> > >  			       dev_num);
> > 
> > Could you change the if check to use IS_ERR(st_class_member) so in the
> > future if do_create_class_files return -E* we will not get a oops.
> > 
> A revised patch is at the end of this message. Thanks for pointing out 
> this bug.

Yeah, this is a much better fix.  Sorry to cause all of this trouble, I
should have checked to see if anyone used the kobject's name of the cdev
structure anywhere before taking that assignement out.

Andrew, this is a better fix than the one that you and Jon came up with
earlier today.

thanks,

greg k-h

> --------------------------------8<----------------------------------------------
> --- linux-2.6.5-rc1-bk2/drivers/scsi/st.c	2004-03-17 22:37:11.000000000 +0200
> +++ linux-2.6.5-rc1-bk2-k1/drivers/scsi/st.c	2004-03-18 00:09:07.000000000 +0200
> @@ -17,7 +17,7 @@
>     Last modified: 18-JAN-1998 Richard Gooch <rgooch@atnf.csiro.au> Devfs support
>   */
>  
> -static char *verstr = "20040226";
> +static char *verstr = "20040318";
>  
>  #include <linux/module.h>
>  
> @@ -4193,20 +4193,25 @@
>  
>  static void do_create_class_files(Scsi_Tape *STp, int dev_num, int mode)
>  {
> -	int rew, error;
> +	int i, rew, error;
> +	char name[10];
>  	struct class_device *st_class_member;
>  
>  	if (!st_sysfs_class)
>  		return;
>  
>  	for (rew=0; rew < 2; rew++) {
> +		/* Make sure that the minor numbers corresponding to the four
> +		   first modes always get the same names */
> +		i = mode << (4 - ST_NBR_MODE_BITS);
> +		snprintf(name, 10, "%s%s%s", rew ? "n" : "",
> +			 STp->disk->disk_name, st_formats[i]);
>  		st_class_member =
>  			class_simple_device_add(st_sysfs_class,
>  						MKDEV(SCSI_TAPE_MAJOR,
>  						      TAPE_MINOR(dev_num, mode, rew)),
> -						&STp->device->sdev_gendev, "%s",
> -						STp->modes[mode].cdevs[rew]->kobj.name);
> -		if (!st_class_member) {
> +						&STp->device->sdev_gendev, "%s", name);
> +		if (IS_ERR(st_class_member)) {
>  			printk(KERN_WARNING "st%d: class_simple_device_add failed\n",
>  			       dev_num);
>  			goto out;
