Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbVIEKoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVIEKoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 06:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVIEKoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 06:44:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49080 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751019AbVIEKoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 06:44:24 -0400
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux clustering <linux-cluster@redhat.com>
Cc: Stephen Tweedie <sct@redhat.com>, David Teigland <teigland@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20050904203344.GA1987@elf.ucw.cz>
References: <20050901104620.GA22482@redhat.com>
	 <20050901035939.435768f3.akpm@osdl.org>
	 <1125586158.15768.42.camel@localhost.localdomain>
	 <20050901132104.2d643ccd.akpm@osdl.org> <20050903051841.GA13211@redhat.com>
	 <20050904203344.GA1987@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1125917048.1910.9.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 05 Sep 2005 11:44:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2005-09-04 at 21:33, Pavel Machek wrote:

> > - read-only mount
> > - "specatator" mount (like ro but no journal allocated for the mount,
> >   no fencing needed for failed node that was mounted as specatator)
> 
> I'd call it "real-read-only", and yes, that's very usefull
> mount. Could we get it for ext3, too?

I don't want to pollute the ext3 paths with extra checks for the case
when there's no journal struct at all.  But a dummy journal struct that
isn't associated with an on-disk journal and that can never, ever go
writable would certainly be pretty easy to do.

But mount -o readonly gives you most of what you want already.  An
always-readonly option would be different in some key ways --- for a
start, it would be impossible to perform journal recovery if that's
needed, as that still needs journal and superblock write access.  That's
not necessarily a good thing.

And you *still* wouldn't get something that could act as a spectator to
a filesystem mounted writable elsewhere on a SAN, because updates on the
other node wouldn't invalidate cached data on the readonly node.  So is
this really a useful combination?

About the only combination I can think of that really makes sense in
this context is if you have a busted filesystem that somehow can't be
recovered --- either the journal is broken or the underlying device is
truly readonly --- and you want to mount without recovery in order to
attempt to see what you can find.  That's asking for data corruption,
but that may be better than getting no data at all.  

But that is something that could be done with a "-o skip-recovery" mount
option, which would necessarily imply always-readonly behaviour.

--Stephen


