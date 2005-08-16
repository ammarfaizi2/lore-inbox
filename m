Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbVHPBQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVHPBQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 21:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbVHPBQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 21:16:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60098 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S965060AbVHPBQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 21:16:56 -0400
Date: Mon, 15 Aug 2005 22:11:21 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alexander Pytlev <apytlev@tut.by>, linux-kernel@vger.kernel.org,
       debian-kernel@lists.debian.org
Cc: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: kernel 2.4.27-10: isofs driver ignore some parameters with mount
Message-ID: <20050816011121.GB7807@dmt.cnet>
References: <1853917171.20050812104417@tut.by> <20050812082936.GB3302@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812082936.GB3302@verge.net.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,

On Fri, Aug 12, 2005 at 05:29:36PM +0900, Horms wrote:
> On Fri, Aug 12, 2005 at 10:44:17AM +0300, Alexander Pytlev wrote:
> > Hello Debian,
> > 
> > Kernel 2.4.27-10
> > With mount isofs filesystem, any mount parameters after
> > iocharset=,map=,session= are ignored.
> > 
> > Sample:
> > 
> > mount -t isofs -o uid=100,iocharset=koi8-r,gid=100 /dev/cdrom /media/cdrom
> > 
> > gid=100 - was ignored
> > 
> > I look in source and find that problem. I make two patch, simply and full
> > (what addeded some functionality - ignore wrong mount parameters)
> 
> Thanks,
> 
> I will try and get the simple version of this patch into the next
> Sarge update.
> 
> I have also CCed Marcelo and the LKML for their consideration,
> as this problem still seems to be present in the lastest 2.4 tree.
> 
> -- 
> Horms
> 
> simply patch:
> ===================================================================================
> --- kernel-source-2.4.27/fs/isofs/inode.c       2005-05-19 13:29:39.000000000 +0300
> +++ kernel-source/fs/isofs/inode.c      2005-08-11 11:55:12.000000000 +0300
> @@ -340,13 +340,13 @@
>                         else if (!strcmp(value,"acorn")) popt->map = 'a';
>                         else return 0;
>                 }
> -               if (!strcmp(this_char,"session") && value) {
> +               else if (!strcmp(this_char,"session") && value) {
>                         char * vpnt = value;
>                         unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
>                         if(ivalue < 0 || ivalue >99) return 0;
>                         popt->session=ivalue+1;
>                 }
> -               if (!strcmp(this_char,"sbsector") && value) {
> +               else if (!strcmp(this_char,"sbsector") && value) {
>                         char * vpnt = value;
>                         unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
>                         if(ivalue < 0 || ivalue >660*512) return 0;
> ===================================================================================

Neither "sbsector" or "session" parameters are part of the options string used 
in Alexander's example, so how come this patch can make any difference? 

Usage of "sbsector" or "session" parameters could explain the above patch
making a difference because the buggy, always true "(unsigned long) ivalue < 0"
comparison invokes "return 0", but that is not the case.

The code after the "popt->iocharset = value;" does not make any sense.

It seems that the "*value = 0" assignment can screw up the rest of the
string, isnt that the real issue?

#ifdef CONFIG_JOLIET
                if (!strcmp(this_char,"iocharset") && value) {
                        popt->iocharset = value;
                        while (*value && *value != ',')
                                value++;
                        if (value == popt->iocharset)
                                return 0;
                        *value = 0;
                } else
#endif





