Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTILGvY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 02:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTILGvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 02:51:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29103 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261409AbTILGvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 02:51:22 -0400
Date: Fri, 12 Sep 2003 08:51:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
       =?iso-8859-1?Q?S=E9bastien?= Hinderer 
	<Sebastien.Hinderer@libertysurf.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Impossible to read files from a CD-Rom
Message-ID: <20030912065116.GA16813@suse.de>
References: <20030818163520.GA413@galois> <20030908152800.GA5224@bouh.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030908152800.GA5224@bouh.famille.thibault.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08 2003, Samuel Thibault wrote:
> Hi,
> 
> On Mon 18 aug 2003 18:35:22 GMT, Sébastien Hinderer wrote:
> > I'm using a vanila linux-2.6.0-test3.
> > When I try to use a CD-Rom, the mount is successful, so are the calls to
> > ls.
> > However, as soon as I try to read a file, I get a lot of messages such as :
> > 
> > hdc: rw=0, want=505092, limit=31544
> > Buffer I/O error on device hdc, logical block 126272
> > attempt to access beyond end of device
> 
> We dug a little bit this Monday with Sebastien, and found out some
> troubles: the call to set_capacity at the end of cdrom_read_toc() writes a
> strange value, which is not always the same, even for the same reinserted
> CD-ROM, seemingly because it came from cdrom_get_last_written():
> 
> cdrom_get_last_written() calls cdrom_get_disc_info(), then
> cdrom_get_track_info() and uses the track_start and track_size to
> compute the limit of the disk. The trouble seems to come from the fact
> that in cdrom_get_track_info(), the info size is got from the drive, but
> no check is done to ensure that it will fill up the whole
> track_information structure, which is not reset to 0 either, so that
> random values remain:
> 
> (linux-2.6.0-test4/drivers/cdrom/cdrom.c:2214)
> 	if ((ret = cdo->generic_packet(cdi, &cgc)))
> 		return ret;
> 	
> 	cgc.buflen = be16_to_cpu(ti->track_information_length) +
> 		     sizeof(ti->track_information_length);
> 
> 	if (cgc.buflen > sizeof(track_information))
> 		cgc.buflen = sizeof(track_information);
> 
> 	cgc.cmd[8] = cgc.buflen;
> 	return cdo->generic_packet(cdi, &cgc);
> 
> The solution would be to return an error if 
> cgc.buflen != sizeof(track_information) after the truncation to
> sizeof(track_information), so that cdrom_get_last_written() will
> correctly fail, and make cdrom_read_toc() use cdrom_read_capacity()
> instead, which gives the correct answer.

It isn't that easy, if that were the case there would be no need for the
above code would there?

This basically boils down to a typical problem with CDROM/DVD drives -
some specific structure may vary a little in size depending on when in
the spec cycle they were implemented. Some drives barf if you try and
read to much, some when you read too little. So the approach that
typically works the best is to just read the very first of the
structure, check the length, and issue a read for the complete data.

I'd be more interested in fixing the real bug: why does your drive
return zero length, and only sporadically?

-- 
Jens Axboe

