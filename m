Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTIEPnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTIEPnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:43:22 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:26886 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263057AbTIEPnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:43:19 -0400
Date: Fri, 5 Sep 2003 12:08:12 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Chris Heath <chris@heathens.co.nz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Jamie Lokier <jamie@shareable.org>,
       linux-kernel@vger.kernel.org, vojtech@ucw.cz,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Message-ID: <20030905120812.A3403@pclin040.win.tue.nl>
References: <20030904230055.GO31590@mail.jlokier.co.uk> <20030905021955.A3133@pclin040.win.tue.nl> <20030904225728.C7CB.CHRIS@heathens.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030904225728.C7CB.CHRIS@heathens.co.nz>; from chris@heathens.co.nz on Thu, Sep 04, 2003 at 11:41:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 11:41:38PM -0400, Chris Heath wrote:

> Well... I think the overall design is the right one.  The atkbd driver
> expects to be talking to an AT keyboard, usually using Set 2.

Always be precise: there are six modes, namely
translated/untranslated Set 1/2/3.

By default every recent keyboard comes up in translated Set 2.
atkbd.c is broken, because it expects what the keyboard does not send,
namely untranslated Set 2.

{and here "send" is not defined as what bits are on some cable,
that is invisible for the programmer and varies between systems,
but as what bits get read by the kernel}

> However, the bytes that come from the i8042 are a mixture of Set 1 and
> Set 2.  Set 1 because the key releases have their 8th bits set, and Set
> 2 because we get the non-XT keys escaped with E0. I guess the keyboard
> is sending Set 2 and the BIOS is translating the set 2 codes to set 1
> for "compatibility with XT software".

There are several misunderstandings in this paragraph.
No, the BIOS is not involved - Linux does not use the BIOS,
except possibly at boot time.
Both translated and untranslated Set 2 use E0 prefixes,
and E0 is translated to E0.

The translation is done by the keyboard controller.
On many laptops the strange construction of a keyboard that sends
the wrong codes, which then are translated by a separate microprocessor,
is thrown out, and the keyboard directly produces the desired codes,
namely translated Set 2, and no translation happens.
Also the compatibility mode of USB only knows about translated Set 2.

> So the i8042 layer is IMHO the right place to untranslate this mess back
> into normal Set 2.

There is nothing normal about this untranslated Set 2.
It is a figment of the imagination.
Laptop hardware doesnt know anything about it.

> The problem is that the translation is not invertible

Yes, indeed, so we introduce some small bugs by doing this silly
untranslation.

> The current algorithm is to untranslate all bytes 0x00-0x7f, and to
> untranslate the others only if there was a previous key press.  This
> means the i8042 layer has to know about scancodes, knowledge which
> probably only belongs in the atkbd layer.

Yes, precisely.

> Probably, now that I think about it, the sanitization of duplicate key
> releases should rightfully be part of the atkbd layer, because those
> codes are actually being sent from the keyboard.

Yes, precisely.
And indeed, no sanitization is needed at all.

> But either way, the problem remains to find a good untranslate
> hack^Walgorithm.  Because we are getting duplicate key releases, we have
> to make sure they they are either untranslated or removed.  Sending them
> through unchanged, as we were in -test1 causes lots of grief to the
> atkbd layer.

But that is a bug in atkbd.

Andries

