Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWDRNnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWDRNnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWDRNnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:43:52 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:8135 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750979AbWDRNnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:43:51 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: "Jon Masters" <jonathan@jonmasters.org>
Subject: Re: [RFC] binary firmware and modules
Date: Tue, 18 Apr 2006 15:37:46 +0200
User-Agent: KMail/1.9.1
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <1145088656.23134.54.camel@localhost.localdomain> <35fb2e590604180616r33a05380p65c0e1c26ae276de@mail.gmail.com>
In-Reply-To: <35fb2e590604180616r33a05380p65c0e1c26ae276de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604181537.47183.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 April 2006 15:16, Jon Masters wrote:
> On 4/15/06, Jon Masters <jcm@redhat.com> wrote:
> 
> > The attached patch introduces MODULE_FIRMWARE as one way of advertising
> > that a particular firmware file is to be loaded - it will then show up
> > via modinfo and could be used e.g. when packaging a kernel. I've also
> > given an example via the QLogic gla2xxx driver.
> 
> Ok. If nobody shouts today I'm going to suggest this go into 2.6.17. I
> think more ellaborate schemes will come up later, but we also need
> something usable out there now.
> 
> As others have pointed out, cunning schemes to hack how
> request_firmware et al work are all very well and good, but often we
> just don't know what firmware we'll need until runtime. Unless or
> until there's a good way to address that, I think modules will need to
> advertise every firmware and distros will have to package all possible
> firmwares, just in case.

Hi Jon, this approach seems mistaken to me.  If I understand it right, 
your mental model is that the driver has a list of file names for firmware
files, and calls user-space with the right file-name for the device in
question.  Given that model, having drivers tell the world about their
firmware file list is reasonable; but I think the model is a bad one.
Much better would be to have drivers work at a higher level of abstraction,
and have user-space map the driver's abstract firmware request to a
particular firmware file.  The kernel should say: I am the x driver,
I want firmware for the y device, my version is v, the device version
is r, etc etc.  Userspace should work out that the appropriate file
is ql2322_fw.bin and upload it.  This is similar to the way the kernel
handles other requests for services, such as loading modules (the kernel
can ask for a particular module, but it can also ask for a module which
provides a certain functionality).  Of course this requires making udev
firmware handling more intelligent.

I gave the example of the speedtouch driver to show how complicated
things can be.  I didn't mean to suggest that the scheme it uses is
a good one - it is a bad one, in that the real solution is to make
userspace smarter.  In any case, I don't see how your suggested patch
could reasonably work with the speedtouch driver - after all, the
driver doesn't have a list of possible firmware files, and can't
have one because no-one knows exactly which files exist or may be
needed; and even if I had a decent list, I think it would be a mistake
to hardwire it into the kernel.

Ciao,

D.
