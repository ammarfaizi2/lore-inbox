Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSGPL1E>; Tue, 16 Jul 2002 07:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSGPL1E>; Tue, 16 Jul 2002 07:27:04 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:18147 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S315419AbSGPL1C>; Tue, 16 Jul 2002 07:27:02 -0400
Date: Tue, 16 Jul 2002 13:28:19 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207161128.g6GBSJPE021316@burner.fokus.gmd.de>
To: James.Bottomley@steeleye.com, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From James.Bottomley@steeleye.com Mon Jul 15 18:09:52 2002

>Actually, the diagram is very similar to what we possess internally today.

>This represents where I think the SCSI stack is going:

>                   User Level
>--------------------------------------------------------------

> +----------------+   +---------------------+
> | Block Interface|   | Character Interface |
> +----------------+   +---------------------+
>         |                        |
>         |   +--------------------+

Why should the character interface be connected to the block layer?
This would contradict UNIX rules.

>         |   |
> +---------------------+
> | Block Layer         |     +----------------------+
> | provides queueing   |     | Device Prep Functions|
> | and elevator if     |     | st, sd, sg, etc.     |
> | necessary.          |-----| Does transport       |
> | Also provides all   |     | translation          |
> | support functions   |     +----------------------+
> | that may be shared  |                |
> | across transports.  |     +----------------------+
> |                     |     | Stackable error      |
> |                     |-----| handling (not well   |
> |                     |     | thought out yet)     |
> |                     |     +----------------------+

Why should the error handlers interface with the block layer?
This is not true for UNIX and it would not help. However, it would
be nice to have a way to make the blocklayer find out that e.g. 
only the last sector  of a multi sector read ahead instruction 
did fail.

> |                     |
> |                     |         +--------------------+
> |                     |         | Transport helper   |
> |                     |         | Contains all fns   |
> |                     |         | not shareable by   |
> |                     |         | other transports   |
> +---------------------+         +--------------------+
>                   |                  |
>                   |                  |
>                 +-------------------------+
>                 | Card driver (deals with |
>                 | attached transport      |
>                 | translation             |
>                 +-------------------------+


>As you can see, I plan to leverage the generic block layer to build the 
>transport stack.  The upper layer drivers become mere request_prep_fns whose 
>job is to translate the request to a transport specific command.

>The struct request will go all the way down to the card driver, but the card 
>driver may choose to deal only with the transport translation if it wants.

>The driving vision for this is to move into the generic block layer as much of 
>the individual transport stack as makes sense (i.e. if other transports can 
>make use of the functions), so, for example, Tag command queueing is already 
>in there and shared between IDE and SCSI.

AFAIK, tagged command queuing is a SCSI specific property, why should this
be part of a generif block layer?
The block layer shuld simply send more than one request before waiting for
the requests to finish. Then a tagged command queuing aware sd.c could choose 
to fill up the tagged queue that is handled by the SCSI glue layer.

>The ultimate end point will be when the correct balance between what belongs 
>in the generic block layer and what belongs in the transport helpers is 
>achieved.  I speculate that, for CDROMS, this will lead to two small request 
>prep modules sharing quite a large helper library (The helper library would do 
>SCSI command translation, and probably the IDE prep module would fix up the 
>transport command for the specific device).  However, I don't rule out that it 
>would lead to a single prep module for both IDE and SCSI.

With my proposal, anything that speaks SCSI is used via SCSI commands and a 
generic SCSI driver like scg.c could access the SCSI transport aware drives
of any type. An important (communication baesed) feature of my SCSI glue layer 
would be to make it possible to insert SCSI commands from scg.c without making 
sd.c believe that something strange and unexpected happened to one of it's drives.

>The device naming issues are totally separate from the above.  I intend that 

Agreed.

>driverfs will cope with them.  Internally, the block layer just thinks of the 
>stack as a series of entry points for physical devices.  Driverfs gives the 
>card driver freedom to provide a hierarchical ascii device name as it sees 
>fit.  Hopefully this will finesse the so called persistent binding issues that 
>plague solaris.

It would help, if somebody would correct the current SCSI addressng scheme used 
in Linux. Linux currently uses something called BUS/channel/target/lun.
This does not reflect reality.

What Linux calls a SCSI bus is definitely not a SCSI bus but a SCSI HBA card.
What Linux calls a channel really is one of possibly more SCSI busses going
off one of the SCSI HBA cards. It makes sense to just count SCSI busses.

>Ultimately, this means that host and channel is subsumed into the card 
>identification scheme, target ID may no longer be a number and even LUN may 
>end up being a LUN hierarchy representation.  As we do this, we'll move to 
>exposing persistent names, so the user shouldn't necessarily care about this.


Why do you believe that you need to have something that is not a bumber?

As a result of your drawing, I introduced the block layer (which is the 
traditional UNIX block cache). I also had the idea that it may be a good
idea to make the simple block based I/O driver part or slave of the SCSI
CDB based driver (although it would use a different portal to the glue layer).
This way, it would be possible to have e.g. a single name space for all
hard disks.


Let me add my modified artwork:

			User programs

----------------------------------------------------------------
----------------------------------------------------------------
|								|
|		Kernel driver interface				|
|								|
----------------------------------------------------------------
		|				|
------------------------			|
|			|			|
| Block I/O layer	|			| Raw I/O IF
|			|			|
------------------------			|
		|				|
Block I/O IF	|				|
		|				|
----------------------------------------------------------------
|				  ------------------------------
|				 |				|
|	One or more SCSI	 |	Block based I/O       	|
|	target drivers		 |	handling routines	|
|	    e.g. sd.c		 |	not used if SCSI based	|
|	st.c, scg.c		 |	I/O is possible to a	|
|				 |	specific drive		|
				  ------------------------------
----------------------------------------------------------------
		|				|
SCSI CDB IF	|		 Block based IF	|------------------ Locked when
		|				|		    SCSI glue
----------------------------------------------------------------    Interface is
|				|				|   used for a
|				|				|   specific
|	SCSI glue layer		|   Block access glue layer	|   drive.
|				|				|
|	Will check if target	|				|
|	supports SCSI commands	|				|
|	and lock Block access	|				|
|	layer in this case.	|				|
|				|				|
----------------------------------------------------------------
|								|
|			 Low level glue				|
|								|
----------------------------------------------------------------
	| SCSI CDB/IF			| SCSI CDB/IF | Block IF
--------------------------------  ------------------------------
|				| |				|
|				| |				|
|	SCSI HBA driver		| |	ATA HBA driver		|
|				| |	deals with simple ATA	|
|	Only supports		| |	interface and with	|
|	SCSI CDB interface	| |	ATA packet interface	|
|				| |				|
|				| |				|
--------------------------------  ------------------------------
Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
