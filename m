Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUFMKwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUFMKwj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 06:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265042AbUFMKwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 06:52:39 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:42291 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S265040AbUFMKwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 06:52:30 -0400
Message-ID: <40CC31E6.8080201@ThinRope.net>
Date: Sun, 13 Jun 2004 19:52:22 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Koblinger Egmont <egmont@uhulinux.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: information leak in vga console scrollback buffer
References: <Pine.LNX.4.58L0.0406122137480.20424@sziami.cs.bme.hu> <20040612204352.GA22347@taniwha.stupidest.org> <Pine.LNX.4.58L0.0406122253580.25004@sziami.cs.bme.hu> <20040612205903.GA22428@taniwha.stupidest.org> <Pine.LNX.4.58L0.0406122301250.25004@sziami.cs.bme.hu> <40CBC094.6050901@ThinRope.net> <Pine.LNX.4.58L0.0406131023260.18435@sziami.cs.bme.hu>
In-Reply-To: <Pine.LNX.4.58L0.0406131023260.18435@sziami.cs.bme.hu>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Koblinger Egmont wrote:
> On Sun, 13 Jun 2004, Kalin KOZHUHAROV wrote:
> 
> 
>> OK, I think I got what you are trying to point out. To reproduce: 
>> 1. login to a (vga) console.
>> 2. less /etc/services; press space to scroll a few screens
>> 3. logout
>> 4. login again on the same console (possibly as a different user)
>> 5. less /etc/resolv.conf
>> 6. press Up, then Shift+PgUp
>> 
>> What is expected: screen should not scroll past your file.
>> 
>> What happens: You can view the previous text (from
>> /etc/services)!!!
> 
> 
> Here you didn't clear the scrollback buffer. Maybe you (or getty)
> executed a clear or a terminal reset but that only affects the
> visible part and not the scrollback buffer. There's absolutely no
> problem so far since everyone knows that the scrollback buffer only
> disappears when you switch to a different console.

Well, I didn't know obviously, now I know.

> My problem is that with a
> really-not-trivial-command-and-key-combination you can possibly see
> /etc/services (in your example) even _after_ you've switched to a
> different console and you are certain that the scrollback buffer is
> no longer available.
> 
> And then what if it's not /etc/services but some private data of
> yours? Maybe other users can later access it. There's no way you can
> protect yourself against it. And you live in a false belief that your
> private data is scrolled out forever.
> 
> Please forget your own test case. Repeat _exactly_ those steps _I_ 
> described in my original post. Then you'll understand what I'm
> talking about.
I tried at first...

Now I did it again:
1. Login on VT2
2. less /etc/services
3. switch to X (VT8 here) and do something
4. switch back to VT2
5. press Shift+PgUp
6. press Up, then press several times Shift+PgUp

What is expected:
screen should not scroll past the beginnign of /etc/services.

What happens:
I saw a bunch of garbage plus pieces of text (/etc/shadow form previous tests and so on), this is a security flaw, NOT feature.

> You sure won't understand my problem if you believe that I'm wrong
> and want to convience me with your own interpretation of my words and
> your own (completely different) test case. Please stick to exactly
> what I reported.
No, I thought you were right, I was just trying to produce a simple testcase :-(

What I was trying ot prove with my testcase is that
a) if you are using mingetty
AND
b) you switch VT after logout (pressing Alt+Right a few times)
the above mentioned scroll-back flow is not observed.

Ok, after tons of new tries, I reproduced it...

I was thinking that every VT has its own scrollback buffer and you are supposed to see what has been on a given VT.
Now I see that you can see things that have been printed on _other_ VTs :-)

I confirm the bug.

There is no connection with {a,min}getty it seems.


Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
|||\/<" 
|||\\ ' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
