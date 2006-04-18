Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWDROOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWDROOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWDROOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:14:11 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:2914 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932142AbWDROOJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:14:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=klEVJX7pbD4AHSINAsHrCYlsiNrFM68XdEZrdg8Fo6jIbKlMXArysUdPee9hn1AnkTFtiQ3EMRn8EYAYp8OckQSWUDqKFyXk1TNDx1rj9wsMkt3h1gEwpyZDQ7fJy6hD4bfGAKwi0QMHvlpXZdERwxF38YHHkWinJX5O4CdMCx8=
Message-ID: <35fb2e590604180714u9bdad58j6c15760404eff330@mail.gmail.com>
Date: Tue, 18 Apr 2006 15:14:08 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Duncan Sands" <duncan.sands@math.u-psud.fr>
Subject: Re: [RFC] binary firmware and modules
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <200604181537.47183.duncan.sands@math.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145088656.23134.54.camel@localhost.localdomain>
	 <35fb2e590604180616r33a05380p65c0e1c26ae276de@mail.gmail.com>
	 <200604181537.47183.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/06, Duncan Sands <duncan.sands@math.u-psud.fr> wrote:
> On Tuesday 18 April 2006 15:16, Jon Masters wrote:
> > On 4/15/06, Jon Masters <jcm@redhat.com> wrote:
> >
> > > The attached patch introduces MODULE_FIRMWARE as one way of advertising
> > > that a particular firmware file is to be loaded - it will then show up
> > > via modinfo and could be used e.g. when packaging a kernel. I've also
> > > given an example via the QLogic gla2xxx driver.
> >
> > Ok. If nobody shouts today I'm going to suggest this go into 2.6.17. I
> > think more ellaborate schemes will come up later, but we also need
> > something usable out there now.
> >
> > As others have pointed out, cunning schemes to hack how
> > request_firmware et al work are all very well and good, but often we
> > just don't know what firmware we'll need until runtime. Unless or
> > until there's a good way to address that, I think modules will need to
> > advertise every firmware and distros will have to package all possible
> > firmwares, just in case.

> Hi Jon, this approach seems mistaken to me.  If I understand it right,
> your mental model is that the driver has a list of file names for firmware
> files, and calls user-space with the right file-name for the device in
> question.

Yes, as is the way it is done right now. There's room for userspace to
massage the request a little but right now it /really shouldn't/
because that's not co-ordinated with the driver.

> Given that model, having drivers tell the world about their
> firmware file list is reasonable; but I think the model is a bad one.

Yes, perhaps it is, but that's how it is now. The point of my mail was
that right now we have zero way to package up a kernel when the
firmware is out-of-tree and this is rapidly becoming reality so we
need a solution right away.

> Much better would be to have drivers work at a higher level of abstraction

Yes, but remember that you then have to embed lots of driver logic in
userspace. Since it's unlikely that driver writers are going to be
able to invest lots of time in keeping what they're doing in sync with
special handling in udev, I think that approach is also a mistake. Do
you really expect to push updated logic into udev every time you
update your driver for a quick hardware change? really?

> I gave the example of the speedtouch driver to show how complicated
> things can be.  I didn't mean to suggest that the scheme it uses is
> a good one - it is a bad one, in that the real solution is to make
> userspace smarter.

I think it's a mistake to take that logic out of the driver proper. To
say "we'll just have userspace figure it out" is asking for weird
undebugable situations. I'm not in favor of bloat, but this is hardly
bloating the kernel - most drivers are going to request firmware by
filename right now, so let's just have a way to export that filename
for the moment at least.

> In any case, I don't see how your suggested patch
> could reasonably work with the speedtouch driver

I own a speedtouch here myself. I had to extract the firmware by hand
and install it. Unless something has changed, this means that we're
not going to get into a situation where that firmware is being shipped
out due to the licensing on it. I get your point (sort of) but I think
you're overcomplicating this for the sake of drivers like speedtouch
where none of this logic works anyway.

I'm not saying this is a perfect approach. It's /an/ approach, it's
simple and it works right now for many possible drivers. Packagers can
trivially rip out info from modinfo and use it as a list of files to
look for in a package (for example). It's also hardly difficult to
switch to a grand magical solution sometime in the future.

Jon.
