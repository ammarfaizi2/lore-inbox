Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWEUSHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWEUSHx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 14:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWEUSHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 14:07:53 -0400
Received: from web25312.mail.ukl.yahoo.com ([217.12.10.84]:21913 "HELO
	web25312.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932398AbWEUSHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 14:07:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0Uqy4PqDG44MtybXQoKZ1kGcg1MGCG7ygCliUNSMMiuuB95meFMG47W7dcuiF8F/F6oSSZn6f7g9Fl5J8xTDDEXk7efOvqRdJ5m54zYdaMGkElgxKnnkUN2C1DN9aIDVt2D1FmpkTty85NNULrCNaXXbDwZ0+p3myj5Pe6ic5Zo=  ;
Message-ID: <20060521180751.18436.qmail@web25312.mail.ukl.yahoo.com>
Date: Sun, 21 May 2006 19:07:51 +0100 (BST)
From: Daniel and Mary-Beth Sherwood <jackanddougal@yahoo.co.uk>
Subject: Re: [PATCH] ATI Remote Control improvements
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay in responding, been busy on other
things.  Answers in line...



List:       linux-kernel
Subject:    Re: [PATCH] ATI Remote Control
improvements
From:       Ville_Syrjälä <syrjala () sci ! fi>
Date:       2006-05-10 14:39:08
Message-ID: pan.2006.05.10.14.39.06.406060 () sci ! fi
[Download message RAW]

On Wed, 10 May 2006 09:12:23 +0100, Daniel Sherwood
wrote:

> 
> Hi
> 
> Please find below a patch to improve the
functionality of the ATI Remote
> Control as follows.
> 
> * Fixed handling of double-click BTN_XXX events that
require the
> input_event timestamp to change between press and
release events.
> * Added module parameter 'xkeycodesonly' to prevent
driver generating
> keycodes that are not recognised by X windows.
(disabled by default)

>>Why?

Because I have not found ay other way to get these
keys  to be recognised by X-windows (xev doesn't give
any feedback on these keys).  If there is another way
then I am happy to use it.

> * Added module parameter 'selectiverepeat' to make
driver only generate
> key repeats for certain keys such and cursor and
volume.  (disabled by
> default)

>>Sounds like this sort of thing could be handled in
>>userspace.
My rationalle here is that the sensitivity of the
remote seems to drop rapidly at around 4-5 meters and
I find that I end up holding the keys for a while
before it responds.  With key-repeats enabled I quite
often ended up with multiple keys being actionned. 
This became quite frustrating so it seemed easier that
only certain keys did repeats.  Mt system now appears
much more responsive and easier to use.

> * Modified filter and key repate support to use
millisecond values set
> by 'filtertime', 'repeatdelay' & 'repeatrate' module
parameters.

>>REP_DELAY and REP_PERIOD?
What do you mean by this?  Am I using the wrong
terminology or are you suggesting that there is a
standard way of doing this (IOCTL?).  If so, then I
can look into modifying it to use this method.

> * Added module parameters 'mouseascursor' &
'mouseascursordefault' to
> allow the mouse area to behave as the normal
cursor-keys.  This
> functionality can optionally be switched with the
'HAND' key.  (disabled
> by default)

>>IIRC it already has cursor keys. Why does it need
more of them?
It does indeed already have cursors, but in my
application (MythTV) there is (in general) no need for
a mouse.  I find that whenever someone else tries to
use the system, they naturally go for the nice big
cursor pad at the top of the remote rather than the
ones at the bottom.

> * Added module parameter 'mousedoubleclick' to make
the double-click
> events actually send two clicks of BTN_LEFT or
BTN_RIGHT rather than
> BTN_SIDE or BTN_EXTRA.  (disabled by default)
> 
> Without specifying module options, the behaviour
will be the same as the
> previous version except for the BTN_XXX click fix
and the filter and key
> repeat handling.


> +			if (kind == KIND_BUTTON) {
> +				struct timeval then, now;
> +				int loop = 1000000;
> +				input_sync(dev);
> +				do_gettimeofday(&then);
> +				do {
> +					do_gettimeofday(&now);
> +				} while( timeval_compare(&now, &then) ==
> 0 && loop-- );

>>Is this for the timestamp thing? Use udelay()?
Yes, this is for the timestamp thing.  I guess
udelay() would be an alternative solution provided
that it can be garunteed to be synchronous with and
have the same resolution as do_gettimeofday().  Do you
know if udelay(0) or udelay(1) will wait until the
next usec edge or the next edge plus one?
Overall, I am not entirely happy with sticking a
live-waiting-loop in the driver, however in this case
it is only for less than 1 microsecond and only when
the mouse button click events are used so it shouldn't
be a problem.  A more reliable solution (for all
drivers) might be to modify the core input handling
drivers to ensure that the timestamp is always
artificially increased between events that occur on
the same timestamp, but this would obviously
complicate the core code to ensure it corrected any
offset as soon as possible and might have other
unforseen side-effects.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-
To unsubscribe from this list: send the line
"unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at 
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
[prev in list] [next in list] [prev in thread] [next
in thread] 

Send instant messages to your online friends http://uk.messenger.yahoo.com 
