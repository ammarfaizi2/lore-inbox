Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbTF2SdL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 14:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbTF2SdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 14:33:11 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:675 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265726AbTF2SdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 14:33:06 -0400
Date: Sun, 29 Jun 2003 14:45:47 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <3EFEEF8F.7050607@post.pl>
To: "Leonard Milcin Jr." <thervoy@post.pl>, linux-kernel@vger.kernel.org
Message-id: <200306291445470220.01DC8D9F@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 3:54 PM Leonard Milcin Jr. wrote:

>Jamie Lokier wrote:
>> John Bradford wrote:
>> I think
>>
>>>the performance of an on-the-fly filesystem conversion utility is
>>>going to be so much worse than just creating a new partition and
>>>copying the data across,
>>
>>
>> which is awfully difficult if you have, say, a 60GB filesystem, a 60GB
>> disk, and nothing else.
>>
>
>I think that filesystem conversion on-the-fly is useless. Why? If you're
>making conversion of filesystem, you have to make good backup of data
>from that filesystem. It is likely that when something goes wrong during
>conversion (power loss) filesystem will be corrupted, and data will be
>lost.

Let's try to make this a bit clearer.  Remember I pointed out,

[QUOTE]
"The first thing ... is that the kernel filesystem drivers must ... allow the
filesystems to draw out the meta-data ... with the data, transmit it to the
conversion functions, and have this data given to them to be rewritten.
This will require a quick pre-pass ... to decide if [it] will actually fit"
[ENDQUOTE]

This applies to the datasystem that is rolled out ontop of this too.  I
did point out that you need to create a transaction-based datasystem
capable of rolling back any changes and storing each state as it goes
so that it is 100% capable of picking up from where it left off without any
data loss.  The way this is done is that before you do anything that alters
the state of the conversion--the "state" being the data that is stored to
explain where each filesystem is, allows them to figure out what they are
doing next, and everything else they need to do--you create a transaction
with all of the original data in it (roll-back, not roll-forward).  Then you begin
the change.  If power is lost, the kernel will recognize that the superblock
on this filesystem is a conversion datasystem, and replay the journal and
continue the conversion as soon as someone tries to mount it.  Nothing
short of a bug in the code can damage it.

The issue is that you need the first filesystem to make space for you, for
the journal and for the conversion datasystem.  It supplies the details of
where to find this space to the CDS, which is used for the journal and such.
The CDS can move blocks around; it is consulted by both filesystems because
blocks may be moved and thus it must find their real physical location.  The
most important one here is the primary superblock, which is moved away from
the beginning of the media.  When the FS wants block N, it asks the CDS
for it.  Thing is, you need space for this.  It will be checked for, to make sure
that there's enough space to do the conversion.

> If you think the data is not worth to make backup - you don't have
>to convert it. Just delete worthless filesystem, and create new one. I
>the data is worth making backup, and finally you make it - you don't
>need to convert it. You could just delete filesystem, and restore data
>from copy. If in turn one think the data is worth to protect it from
>loss, but he will not do it... he risks that the data will be lost, and
>he should not get access to such things.
>

Nrrrg.  Yeah, I've got 80 gig and only CDR's to back up to, and no money.
A CDR may read for me the day it's written, and then not work the next
day.  Still a risk.

>I think that copying data to another filesystem, and restoring it to
>newly created  is most of the time best and fastest method of converting
>filesystems.
>

If you have the space.

>Regards,
>
>Leonard Milcin Jr.
>
>--
>"Unix IS user friendly... It's just selective about who its friends are."
>                                                        -- Tollef Fog Heen
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



