Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTIITVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbTIITUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:20:06 -0400
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:61879 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S264346AbTIITTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:19:20 -0400
Date: Mon, 8 Sep 2003 17:28:00 +0200
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: =?iso-8859-1?Q?S=E9bastien?= Hinderer 
	<Sebastien.Hinderer@libertysurf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Impossible to read files from a CD-Rom
Message-ID: <20030908152800.GA5224@bouh.famille.thibault.fr>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	=?iso-8859-1?Q?S=E9bastien?= Hinderer <Sebastien.Hinderer@libertysurf.fr>,
	linux-kernel@vger.kernel.org
References: <20030818163520.GA413@galois>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030818163520.GA413@galois>
User-Agent: Mutt/1.4i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon 18 aug 2003 18:35:22 GMT, Sébastien Hinderer wrote:
> I'm using a vanila linux-2.6.0-test3.
> When I try to use a CD-Rom, the mount is successful, so are the calls to
> ls.
> However, as soon as I try to read a file, I get a lot of messages such as :
> 
> hdc: rw=0, want=505092, limit=31544
> Buffer I/O error on device hdc, logical block 126272
> attempt to access beyond end of device

We dug a little bit this Monday with Sebastien, and found out some
troubles: the call to set_capacity at the end of cdrom_read_toc() writes a
strange value, which is not always the same, even for the same reinserted
CD-ROM, seemingly because it came from cdrom_get_last_written():

cdrom_get_last_written() calls cdrom_get_disc_info(), then
cdrom_get_track_info() and uses the track_start and track_size to
compute the limit of the disk. The trouble seems to come from the fact
that in cdrom_get_track_info(), the info size is got from the drive, but
no check is done to ensure that it will fill up the whole
track_information structure, which is not reset to 0 either, so that
random values remain:

(linux-2.6.0-test4/drivers/cdrom/cdrom.c:2214)
	if ((ret = cdo->generic_packet(cdi, &cgc)))
		return ret;
	
	cgc.buflen = be16_to_cpu(ti->track_information_length) +
		     sizeof(ti->track_information_length);

	if (cgc.buflen > sizeof(track_information))
		cgc.buflen = sizeof(track_information);

	cgc.cmd[8] = cgc.buflen;
	return cdo->generic_packet(cdi, &cgc);

The solution would be to return an error if 
cgc.buflen != sizeof(track_information) after the truncation to
sizeof(track_information), so that cdrom_get_last_written() will
correctly fail, and make cdrom_read_toc() use cdrom_read_capacity()
instead, which gives the correct answer.

The same remark applies to cdrom_get_disc_info().

Regards,
Samuel Thibault
