Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTAJPFf>; Fri, 10 Jan 2003 10:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbTAJPFf>; Fri, 10 Jan 2003 10:05:35 -0500
Received: from host194.steeleye.com ([66.206.164.34]:56076 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265135AbTAJPFc>; Fri, 10 Jan 2003 10:05:32 -0500
Message-Id: <200301101514.h0AFEBc03067@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: sd_read_cache_type 
In-Reply-To: Message from Andries.Brouwer@cwi.nl 
   of "Fri, 10 Jan 2003 14:08:53 +0100." <UTC200301101308.h0AD8r021919.aeb@smtp.cwi.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Jan 2003 10:14:11 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl said:
> Will look a bit more at the details later. For now a question: this
> call does a MODE_SENSE with the DBD (disable block descriptors) bit
> set. Is there a reason for that? Wouldn't the same code work in the
> same way without that bit? 

The reason was just least line of resistance.  The code doesn't use the block 
descriptors, so there's no need to ask for them.  The code is written to skip 
over the block descriptors, just in case the device returns them, so setting 
DBD to zero should have no practical effect.

Andries.Brouwer@cwi.nl said:
> And the reason I ask is that we already have sd_do_mode_sense6(), so
> part of sd_read_cache_type() can be simply replaced by a call of
> sd_do_mode_sense6(), but the latter needs an extra parameter if DBD is
> really needed.

I agree with replacing the functionality with this call.  On general 
principle, the DBD bit (and any other missing pieces) should be added to 
mode_sense6 just to make it as useful as possible (and, I suppose, the call 
should be moved into scsi_lib since more than just sd could make use of it).

> And a second question: sd_read_cache_type() is called also when no
> medium is present. Objections against only calling when media are
> present?

Well, the cache is pretty often part of the permanent assembly, not part of 
the removable medium, so I think it should still be called for removable 
media. That begs the question, of course, what should the cache type be---it 
strikes me as rather unsafe to have a removable RW medium with a write back 
cache?  I suppose at the very least we should to a SYNCHRONIZE on ejection if 
it's write back?

James


