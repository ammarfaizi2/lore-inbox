Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVCHBVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVCHBVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVCHBRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 20:17:43 -0500
Received: from natpreptil.rzone.de ([81.169.145.163]:51633 "EHLO
	natpreptil.rzone.de") by vger.kernel.org with ESMTP id S261954AbVCHBOo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 20:14:44 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Albert Cahalan <albert@users.sf.net>
Subject: Re: [patch] inotify for 2.6.11
Date: Tue, 8 Mar 2005 02:00:11 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       hch@infradead.org, rml@novell.com, ttb@tentacle.dhs.org,
       torvalds@osdl.org
References: <1110165231.1967.16.camel@cube>
In-Reply-To: <1110165231.1967.16.camel@cube>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503080200.14101.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maandag 07 März 2005 04:13, Albert Cahalan wrote:
> Christoph Hellwig writes:
> > See the review I sent.  Write is exactly the right interface for that kind
> > of thing.  For comment vs argument either put the number first so we don't
> > have the problem of finding a delinator that isn't a valid filename, or
> > use '\0' as such.
> 
> That's just putrid. You've proposed an interface that
> combines the worst of ASCII with the worst of binary.

I guess it's possible to avoid the need for passing the command at all.
The read data already has a format that mixes binary and variable-length
ascii data, so write could use a data structure similar (or even identical)
to the one used there, e.g.

struct inotify_watch_request {
 __u32  mask;  /* watch mask */
 __u32  len;  /* length (including nulls) of name */
 char  name[0]; /* stub for name */
};

This can replace both INOTIFY_WATCH and INOTIFY_IGNORE, if you simply
define a zero mask as a special value for ignore. FIONREAD is a
well-established interface, so I don't think it's necessary to replace
this.

> Adding plain old syscalls is rather nice actually.
> It's only a pain at first, while waiting for glibc
> to catch up.

Yes, that might be a workable interface as well, but don't mix syscalls
with a misc device then. Instead, you might build on something like
futexfs, with syscalls replacing both ioctl and read:

int inotify_open(int flags);
int inotify_watch(int fd, unsigned mask, char *name);
int inotify_ignore(int fd, int wd);
int inotify_getevents(int fd, int max_events, struct inotify_event *);

 Arnd <><
