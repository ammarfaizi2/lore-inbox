Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264733AbTF2Umw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265724AbTF2Ukj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:40:39 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:63615 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265109AbTF2UkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:40:14 -0400
Date: Sun, 29 Jun 2003 16:53:37 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <3EFF4F00.9040608@sktc.net>
To: "David D. Hagood" <wowbagger@sktc.net>, linux-kernel@vger.kernel.org
Message-id: <200306291653370510.02519C1F@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEEC3.30505@sktc.net>
 <200306291431080580.01CF24BF@smtp.comcast.net> <3EFF4443.8080507@sktc.net>
 <200306291605400290.0225B33F@smtp.comcast.net> <3EFF4F00.9040608@sktc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 3:41 PM David D. Hagood wrote:

>rmoser wrote:
>
>> Except for a crash at the precise moment that data is being written
>during
>> a resize of a partition in LVM or the filesystem iteself.  To my
>knowledge,
>> said operation is not journaled.
>
>And the window of vulnerability for my method is very small - for yours
>it is very large (the whole duration of the conversion operation.)
>

Wrong.  Go read it. Citing the original post:

[QUOTE]
1) Create a method for storing meta-data for each file/directory on a filesystem
which is being slowly destroyed. [...]  It is
preferable to make this datasystem fault tolerant, so that if it goes down, the
conversion can be continued without damage. [...]
  - Object oriented:  Store meta-data that may not be recognized by the new
    filesystem
  - Journalized:  Don't break!
[...]
  - Store data that is needed to resume the conversion at any time: There may be
    a collossal system crash during conversion!
  - Differentiate between each filesystem structure and the datasystem used during
    conversion:  Must be able to disassemble one filesystem and reassemble it to
    another WITHOUT getting lost!
[ENDQUOTE]

Everything that happens everywhere should be roll-back journalized, so that if anything
happens, we don't finish what we did but instead go back to the immediate prior
consistent state that will allow us to continue on with our work.  There is only one
vulnerability point:  the final swapping out of the datasystem's superblock for the new
filesystem's superblock at the very end.  There's a way to fix this too.  Display to the
user where exactly the journal is.  Then stop.  He writes this number down.  Then, you
journal the change, as in roll-forward journaling, so it will complete if it crashes.  If
for some reason the machine drops--kernel panic, power outage, cat finds the reset
button--you run the conversion against the system and request to replay journal at
the offset it gave you.  The journal in this special case is sitting in a chunk of free
space in the filesystem somewhere, and houses only this one transaction.  This means
that once this transaction finishes, the journal is just some random data written
to that area in the middle of free space on the filesystem.  It's unimportant, and doesn't
have to be removed because there are no references to it.

>Sorry, but I've seen too many folks like you in the past on lists like
>this. You write in with a poorly considered idea, and when people try to
>show you why it won't work you plug your ears and say
>"Nyah-Nyah-Nyah-I'm-not-listening".
>
>As I said before: if you think this is so easy to do, DO IT. SHOW US THE
>CODE.
>

I wish.

>Until you do, I consider this "discussion" at an end.

--Bluefox Icy

