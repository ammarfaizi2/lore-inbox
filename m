Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317340AbSHAX1Y>; Thu, 1 Aug 2002 19:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSHAX1Y>; Thu, 1 Aug 2002 19:27:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21509 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317340AbSHAX1X>; Thu, 1 Aug 2002 19:27:23 -0400
Date: Thu, 1 Aug 2002 16:30:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers 
In-Reply-To: <Pine.LNX.4.44.0208020009490.28515-100000@serv>
Message-ID: <Pine.LNX.4.33.0208011613440.1315-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ I'm having a real hard time to not shout at the top of my lungs "SHUT
  THE FUCK UP ABOUT THIS ALREADY!" and then running around the offices 
  with a chainsaw laughing maniacally. But I'll try. This once. ]

On Fri, 2 Aug 2002, Roman Zippel wrote:
> 
> Relying on that the fd will always point to a normal file is only asking
> for trouble.

People _do_ rely on regular files working this way. Wake up and smell the
coffee, you cannot change reality by just arguing about it.

There are cases where you absolutely _have_ to rely on this documented
UNIX behaviour. One example is using a log-file (yes, a _file_, not a
socket or a pipe) that you explicitly opened with O_APPEND, just so that
you can guarantee _atomic_ writes that do not get lost or partially
re-ordered in your log.

And yes, these logging programs are mission-critical, and they do have
signals going on, and they rely on well-defined and documented interfaces
that say that doing a write() to a filesystem is _not_ going to return in
the middle just because a signal came in.

These programs know what they are doing. They are explicitly _not_ using
"stdio" to write the log-file, exactly because they cannot afford to have
the write broken up into many parts (and they do not want to have it
buffered either, since getting the logging out in a timely fashion can be
important). 

The only, and the _portable_ way to do this under UNIX is to create one
single buffer, and write it out with one single write() call. Anything
else is likely to cause the file to be interspersed by random
log-fragments, instead of being a nice consecutive list of full log
entries.

Feel free to change Linux to have your stupid preferred semantics where
everybody is supposed to be able to handle signals at any time, but please
re-name it to "Crapix" when you do. Because that is what it would be.  
Crap. Utter braindamage.

If people cannot find this in SuS, then I simply don't _care_. I care
about not having a crap OS, and I also care about not having to repeat
myself and give a million examples of why the current behaviour is
_required_, and why we're not getting rid of it.

[ Did profanity help explain the situation? Do people finally understand 
  why this _really_ isn't up for discussion? Please don't bother sending 
  me any more email about this.  My co-workers are already eyeing me and 
  my chainsaw nervously. Thank you for sparing them. ]

			Linus

