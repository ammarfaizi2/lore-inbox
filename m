Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268268AbTALLMN>; Sun, 12 Jan 2003 06:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268270AbTALLMN>; Sun, 12 Jan 2003 06:12:13 -0500
Received: from hera.cwi.nl ([192.16.191.8]:58305 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268268AbTALLML>;
	Sun, 12 Jan 2003 06:12:11 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 12 Jan 2003 12:20:38 +0100 (MET)
Message-Id: <UTC200301121120.h0CBKcD18904.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, zaitcev@redhat.com
Subject: Re: [PATCH] sd.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > +        /*
    > +         * If manual intervention is required, or this is an
    > +         * absent USB storage device, a spinup is meaningless.
    > +         */
    > +        if (SRpnt->sr_sense_buffer[2] == NOT_READY &&
    > +            SRpnt->sr_sense_buffer[12] == 4 /* not ready */ &&
    > +            SRpnt->sr_sense_buffer[13] == 3)

    Why is this not inside media_not_present?

It is bad to have a routine do something other than its name says.
I wrote media_not_present() and made it test for precisely that:
3A: medium not present.
Here we have "not ready, manual intervention required".
There are so many different SCSI devices - there might well be some
where the reason for the need of manual intervention is different.
And indeed our usb-storage code synthesizes this for the case
where the device (rather than the media) is absent.

    > + * sd_read_cache_type - called only from sd_init_onedisk()

    Was it necessary to move and change sd_read_cache_type
    simultaneously? Makes a joke of the diff.

It calls sd_do_mode_sense6, so if sd_read_cache_type was
not moved we would had to add a prototype of sd_do_mode_sense6.
Moreover, this was the right place.
Sooner or later we'll want to merge it with the routine before.

    > +    /* without media there is no reason to ask;
    > +       moreover, some devices react badly if we do */
    > +    if (sdkp->media_present)
    > +        sd_read_cache_type(sdkp, disk->disk_name, SRpnt, buffer);

    Hmm... cautiously ok.

    -- Pete

Andries


Now that I reply anyway, let me store some of my waste paper in the
net archives, before throwing it away.

(i) The DBD bit is there for completeness, but not because it is
needed. I know of no devices that need it or that react badly to it.

(ii) The Imation FlashGo! returns Not Ready, Medium not present
without card, and 03 00 00 08 in sd_read_cache_type() with DBD bit,
and 0B 00 00 08 00 00 3D FF 00 00 02 00 without DBD bit,
when fed with an 8 MB CF card. This shows that if one asks for a mode
page that the device does not have, where most devices will reply
Illegal Request - Invalid Field in parameter list (or: in CDB),
some devices just return zero bytes following the header.

