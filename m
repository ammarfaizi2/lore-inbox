Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136805AbRECMyp>; Thu, 3 May 2001 08:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136803AbRECMy0>; Thu, 3 May 2001 08:54:26 -0400
Received: from stat8.steeleye.com ([63.113.59.41]:43795 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S136801AbRECMyK>; Thu, 3 May 2001 08:54:10 -0400
Message-Id: <200105031253.IAA00988@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Doug Ledford <dledford@redhat.com>
cc: Mike Anderson <mike.anderson@us.ibm.com>,
        Eric.Ayers@intec-telecom-systems.com,
        James Bottomley <James.Bottomley@steeleye.com>,
        "Roets, Chris" <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi 
In-Reply-To: Message from Doug Ledford <dledford@redhat.com> 
   of "Wed, 02 May 2001 16:31:16 EDT." <3AF06E94.15399CDF@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 May 2001 08:53:42 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dledford@redhat.com said:
> Correct, if you hold a reservation on a device for which you have
> multiple paths, you have to use the correct path. 

As far as multi-path scsi reservations go, the SCSI-2 standards (and this 
includes the completion in the SCSI-3 SPC) is very malleable.  The standard is 
very explicit about multi-port targets but vague about whether initiator means 
one port of the initiator or all ports.

If you interpret the standard most stricly, you can read that acquiring a 
reservation on one port locks everyone (including you) out of all the other 
ports.  However, vendors of symmetric active multi-port arrays tend rather to 
frown on this interpretation.  They take the view that a reservation acquired 
by an initiator on one port ought to allow that initiator access on all the 
other ports (otherwise what's the point of being symmetric active).  This can 
only be done if you make assumptions about how you identify the same initiator 
on a different port.  EMC, I believe, assumes that the initiator always has 
the same SCSI ID.  Note, however, that the same SCSI ID assumption will fail 
in a multi-path point-to-point configuration where all initiators could have 
the same ID.

This rather unmanageable state of affairs is the reason for SCSI-3 
reservations.  Since each initiator is now known by a key, you can always be 
sure to grant access correctly in a multi-ported environment.

The bottom line is that if you use SCSI-2 reservations in multi-port 
environments, the results are extremely vendor specific.

James



