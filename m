Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285013AbRLZWzF>; Wed, 26 Dec 2001 17:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285020AbRLZWy4>; Wed, 26 Dec 2001 17:54:56 -0500
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:30387 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S285013AbRLZWyp>; Wed, 26 Dec 2001 17:54:45 -0500
Subject: Re: Cryptoapi on 2.4.17 (2 patches)
From: Herbert Valerio Riedel <hvr@hvrlab.org>
To: Zygo Blaxell <umsfalfb@umail.furryterror.org>
Cc: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org, andrea@suse.de,
        alan@lxorguk.ukuu.org.uk, axboe@suse.de
In-Reply-To: <20011226220358.GA32128@feedme.hungrycats.org>
In-Reply-To: <20011226220358.GA32128@feedme.hungrycats.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 26 Dec 2001 23:54:38 +0100
Message-Id: <1009407278.12993.2.camel@janus.txd.hvrlab.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello!

On Wed, 2001-12-26 at 23:03, Zygo Blaxell wrote:
> I have two patches, one for cryptoAPI (current CVS) and one for the
> Linux kernel (2.4.17).  
first of all, thanks for getting involved! :-)
 
> The cryptoapi patch fixes a silly symbol name bug.  The
well, that's due to the WIP state of the CVS... I was in the midst of
back-porting the development I did for the new int. patches at
http://www.kernel.org/pub/linux/kernel/people/hvr/testing/
when this time-consuming christmas event started becoming unignorable...
C;-)
 
> patch for the Linux kernel changes the default lo_iv_mode to
> LO_IV_MODE_SECTOR--otherwise, the patch is just a straightforward port
> of the patch in cryptoapi/doc in cryptoavi CVS.

 
> I noticed that there doesn't seem to be a way to set lo_iv_mode from
> user-space, not even with a module or kernel command-line parameter.
> Is this just one of those features that isn't implemented yet, or did
> I miss something?
the 'unimplemented'-choice applies;
but there's more... I'm glad you picked up the issue again, since it was
again starting to fall into oblivion... :-/

there are two different approaches, the first one I tried, was the one
seen in the cryptoapi-packaging, i.e. backward compatible; un-aware
loop-filters would get the old (broken) iv metric, while aware filters
could aktivate the 512-byte metric...
this approach was deemed an ugly 'toothpaste-back-to-tube' approach, but
it tried not to break old filters...
a few weeks ago, I retried to bring the issue on, in order to get the
patches somehow included into the mainstream-kernel; all parties agreed
that we could as well break the old iv-mode, and just default to the
better 'new' one... that way old filters may break the on-disk format,
but they will automatically become iv-safe; and if one really cares, you
can calculate the old iv from the new iv (just see the new int.patch and
cryptoloop_cfg below...)... BUT... as of now (2.4.17), the kernel still
uses the old IV scheme... it seems I'm not very good at being annoying
enough in order to get patches into the kernel... ;-)

well, if you take a look at the above mentioned testing-directory,
you'll find a cryptoloop_cfg.c which is some kind of user-space tool for
controlling the iv metric somewhat... it's more or less a hack, which
only works (if at all) when used in conjunction with the loop-hvr patch
(and the latest patch-int in that directory) the tool's provided for
converting your old non-512-iv metric encrypted volumes to more flexible
'atomar-sector-sized'-iv encrypted ones by doing something like
(untested --> make backups before trying it at home... or keep both
pieces...)

# losetup -e ...  /dev/loop0 /dev/blockdev
# cryptoloop_cfg /dev/loop0 --set-blksize 0
    if you happen to know the previously used iv size, then use that one
    instead of '0' which uses the transfer chunks' size as iv size...
    also verify /dev/loop0 contains a properly decrypted content!
    mounting it would be a good idea, because the soft blocksize is set
    by the filesystem code -- this is needed when using '0' as
    --set-blksize arg!!!...]
# losetup -e ... /dev/loop1 /dev/blockdev
    that's for the new encrypted data, you can use the chance to change
    encryption parameters as well... i.e. another cipher or
    passphrase...
    and now for the important step: (make sure the filesystem isn't
    mounted anymore)
# dd if=/dev/loop0 of=/dev/loop1
    this will take some time... it will decrypt the data per /dev/loop0
    and encrypt it through /dev/loop1 back to /dev/blockdev
    on-the-fly... (you could use also different /dev/blockdev's if you
    don't trust this procedure...)
# losetup -d /dev/loop0
    unloop /dev/loop0...
    ...now you should have completed the conversion... /dev/loop1 should
    contain your unencrypted data... and /dev/blockdev the new encrypted
    view of it...

> The patches seem to work:  I can swap on an rc6 encrypted partition
> using the patches, and I can create an ext2 filesystem on an rc6 loopback
> file, copy some data to it, unmount, losetup -d, losetup -e, mount it
> again, and _still access the data afterwards_.  Whee!
...well, if it wasn't so, you'd have implemented some kind of data
shredder... *g*

regards,
-- 
Herbert Valerio Riedel       /    Phone: (EUROPE) +43-1-58801-18840
Email: hvr@hvrlab.org       /    Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F
4142

