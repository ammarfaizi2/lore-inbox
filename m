Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131657AbQJ2MkW>; Sun, 29 Oct 2000 07:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131663AbQJ2MkM>; Sun, 29 Oct 2000 07:40:12 -0500
Received: from hermes.mixx.net ([212.84.196.2]:27922 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131657AbQJ2Mjw>;
	Sun, 29 Oct 2000 07:39:52 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: page->mapping == 0
Date: Sun, 29 Oct 2000 13:39:50 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-39FC1A96.F2D5C47D@innominate.de>
In-Reply-To: <14841.7644.853174.666385@argo.linuxcare.com.au> 	<Pine.LNX.4.10.10010262325440.864-100000@penguin.transmeta.com> <14843.61434.167836.293141@argo.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 972823190 10655 10.0.0.90 (29 Oct 2000 12:39:50 GMT)
X-Complaints-To: news@innominate.de
To: paulus@linuxcare.com.au
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test8 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> I am not any kind of expert on the page cache but it seems to me that
> maybe after locking the page we should check if it is still the page
> we want (i.e. page->mapping and page->index are still correct), and go
> back and look up the page again if not.  Presumably there will be
> quite a few places besides do_generic_file_read where that check would
> be needed also.

I'm getting at least some kind of clue about the page cache, though I
don't claim to be an expert.  You've pointed out how the operation of
becoming a reader on a page can fail because the page disappears while
you're waiting.  That's an error, right?  It's the result of a user
space race, which in turn is the result of parallel processes doing
nonatomic file operations with no synchronization.  It sounds like
bailing out of the file_read if the page turns out to be unmapped after
the lock is the right thing to do, at least for a quick fix.

  http://lxr.linux.no/source/mm/filemap.c?v=2.4.0-test9#L1029

There actually aren't that many places where lock_page is called:

  http://lxr.linux.no/ident?v=2.4.0-test9;i=lock_page

Maybe lock_page needs to return an error code.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
