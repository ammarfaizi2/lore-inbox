Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317504AbSGOQG4>; Mon, 15 Jul 2002 12:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317505AbSGOQGz>; Mon, 15 Jul 2002 12:06:55 -0400
Received: from host194.steeleye.com ([216.33.1.194]:37646 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317504AbSGOQGw>; Mon, 15 Jul 2002 12:06:52 -0400
Message-Id: <200207151109.g6FB9bK02279@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: IDE/ATAPI in 2.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Jul 2002 06:09:37 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James.Bottomley@SteelEye.com said:
> As my textual description has not been read, here comes a acsii art of
> the proposal for a driver structure:

Actually, the diagram is very similar to what we possess internally today.

This represents where I think the SCSI stack is going:

                   User Level
--------------------------------------------------------------

 +----------------+   +---------------------+
 | Block Interface|   | Character Interface |
 +----------------+   +---------------------+
         |                        |
         |   +--------------------+
         |   |
 +---------------------+
 | Block Layer         |     +----------------------+
 | provides queueing   |     | Device Prep Functions|
 | and elevator if     |     | st, sd, sg, etc.     |
 | necessary.          |-----| Does transport       |
 | Also provides all   |     | translation          |
 | support functions   |     +----------------------+
 | that may be shared  |                |
 | across transports.  |     +----------------------+
 |                     |     | Stackable error      |
 |                     |-----| handling (not well   |
 |                     |     | thought out yet)     |
 |                     |     +----------------------+
 |                     |
 |                     |         +--------------------+
 |                     |         | Transport helper   |
 |                     |         | Contains all fns   |
 |                     |         | not shareable by   |
 |                     |         | other transports   |
 +---------------------+         +--------------------+
                   |                  |
                   |                  |
                 +-------------------------+
                 | Card driver (deals with |
                 | attached transport      |
                 | translation             |
                 +-------------------------+


As you can see, I plan to leverage the generic block layer to build the 
transport stack.  The upper layer drivers become mere request_prep_fns whose 
job is to translate the request to a transport specific command.

The struct request will go all the way down to the card driver, but the card 
driver may choose to deal only with the transport translation if it wants.

The driving vision for this is to move into the generic block layer as much of 
the individual transport stack as makes sense (i.e. if other transports can 
make use of the functions), so, for example, Tag command queueing is already 
in there and shared between IDE and SCSI.

The ultimate end point will be when the correct balance between what belongs 
in the generic block layer and what belongs in the transport helpers is 
achieved.  I speculate that, for CDROMS, this will lead to two small request 
prep modules sharing quite a large helper library (The helper library would do 
SCSI command translation, and probably the IDE prep module would fix up the 
transport command for the specific device).  However, I don't rule out that it 
would lead to a single prep module for both IDE and SCSI.

The device naming issues are totally separate from the above.  I intend that 
driverfs will cope with them.  Internally, the block layer just thinks of the 
stack as a series of entry points for physical devices.  Driverfs gives the 
card driver freedom to provide a hierarchical ascii device name as it sees 
fit.  Hopefully this will finesse the so called persistent binding issues that 
plague solaris.

Ultimately, this means that host and channel is subsumed into the card 
identification scheme, target ID may no longer be a number and even LUN may 
end up being a LUN hierarchy representation.  As we do this, we'll move to 
exposing persistent names, so the user shouldn't necessarily care about this.

James Bottomley


