Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264593AbRFTULt>; Wed, 20 Jun 2001 16:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264606AbRFTULj>; Wed, 20 Jun 2001 16:11:39 -0400
Received: from voyager.powersurfr.com ([24.109.67.8]:54034 "EHLO
	unity.starfire") by vger.kernel.org with ESMTP id <S264593AbRFTULZ>;
	Wed, 20 Jun 2001 16:11:25 -0400
From: Maciek Nowacki <maciek@Voyager.powersurfr.com>
Date: Wed, 20 Jun 2001 14:11:20 -0600
To: Tom Diehl <tdiehl@pil.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another?
Message-ID: <20010620141119.A5660@wintermute.starfire>
In-Reply-To: <Pine.LNX.4.33.0106191646330.17727-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106191646330.17727-100000@localhost.localdomain>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 04:55:10PM -0400, Tom Diehl wrote:
> On Tue, 19 Jun 2001, Alan Cox wrote:
> 
> > Other than making sure you configure it for the box it will eventually run
> > on - nope you have it all sorted. If you use modules you'll want to install
> > the modules on the target machine too
> 
> What is the best way to install the modules? Is there a directory _all_ of
> the modules exist in b4 you do "make modules_install". I usually end up
> setting EXTRAVERSION to something unique and doing a make modules_install.
> That way it does not hose up the modules for the build machine.
> Is there a better way?

Change MODLIB in $(TOPDIR)/Makefile (e.g. /usr/src/linux/Makefile). I do this
to compile the kernel and modules without root priviledges at all. make
modules_install will fail at the end when trying to run 'depmod', but that's
okay - you can do that yourself:

(TOPDIR=${HOME}/linux, MODLIB=${HOME}/kernel/<revision>/modules)

cd $TOPDIR
make config dep clean bzImage modules && cp arch/i386/boot/bzImage System.map \
${MODLIB}/../ && make modules_install || echo modules_install failed as expected
cd ${MODLIB}/../
mkdir -p lib/modules
ln -s ${PWD}/modules lib/modules/`uname -r`
depmod -F System.map -C /dev/null -b $PWD -r -a

Note that Joe Average user can do all of this, root need not be involved at
all.

Then fix up the resulting modules.dep with sed, I don't remember what depmod
gives you exactly so I can't type out the exact command.. then clean up:

rm lib/modules/`uname -r` ; rmdir lib/modules lib

Now you have a nice kernel package ready to go in $HOME/kernel. Don't forget
to copy $MODLIB into the right spot (rename the directory to the kernel's
revision) and chown -R root or modutils will pout, unless you are making a
romfs or such where the only user is root :-)  nfs will work just fine without
security qualms since the kernel installation is non-root owned. (for
large-scale deployment, you probably can't beat having machines booting from
a server and fetching new romfs images each boot.)

btw, the abuse of depmod in this way isn't very nice, but afaics there is no
other way. I would personally like depmod to dump dependency information for
any valid module tree, expanding the definition of valid to include trees not
prefixed by /lib/modules/`uname -r`, but oh well, it gets by in the end as so
many other things do ;-)

Maciek
