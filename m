Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129247AbQJ3B5p>; Sun, 29 Oct 2000 20:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129556AbQJ3B5f>; Sun, 29 Oct 2000 20:57:35 -0500
Received: from hermes.mixx.net ([212.84.196.2]:37905 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129247AbQJ3B53>;
	Sun, 29 Oct 2000 20:57:29 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: page->mapping == 0
Date: Mon, 30 Oct 2000 02:57:26 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-39FCD586.E5F480A7@innominate.de>
In-Reply-To: <Pine.LNX.4.10.10010291100030.18939-100000@penguin.transmeta.com> <Pine.LNX.4.10.10010291118140.19109-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 972871047 22177 10.0.0.90 (30 Oct 2000 01:57:27 GMT)
X-Complaints-To: news@innominate.de
To: Linus Torvalds <torvalds@transmeta.com>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test8 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Now, I don't think this is really a valid usage pattern, so it's most
> likely to be a result of a buggy application, but I can imagine having
> some strange kind of user-space VM memory management scheme that depends
> on SIGBUS to maintain a file length. I've never heard of such a thing, but
> I could imagine somebody doing some kind of persistent data object store
> in user space this way.
> 
> Does anybody actually know of an application that does something like
> this? Because I'm more and more inclined to just going with the half-fix
> for now. It would at least guarantee internal kernel data consistency (and
> no oopses, of course).
> 
> Don't get me wrong - we need to clean this part up, but as far as I can
> tell we have never done this "right", so in that sense it's not a new
> 2.4.x bug and it can't break existing applications.

Strace shows that the history really is updated with no locking:

  4030  open("/home/phillips/.bash_history", O_WRONLY|O_TRUNC) = 4
  4030  write(4, "l\nless README\ne ../*test8/fs/ext"..., 7546) = 7546
  4030  close(4)                          =
0                                                                                                

There's no reason to continue doing the read after you've detected the
page was pulled out from under you - clearly it's a user error state,
the only question is: return the error and break the buggy application? 
Or gloss over it.  And it seems like returning the error might actually
break bash - maybe it deserves it... but...

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
