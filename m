Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132883AbRDUU11>; Sat, 21 Apr 2001 16:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132889AbRDUU1R>; Sat, 21 Apr 2001 16:27:17 -0400
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:35080 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S132883AbRDUU1C>; Sat, 21 Apr 2001 16:27:02 -0400
Date: Sat, 21 Apr 2001 22:26:58 +0200 (CEST)
From: Herbert Valerio Riedel <hvr@hvrlab.org>
X-X-Sender: <hvr@janus.txd.hvrlab.org>
To: Andi Kleen <ak@suse.de>
cc: Peter Makholm <peter@makholm.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Idea: Encryption plugin architecture for file-systems
In-Reply-To: <20010421213751.A13395@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.33.0104212200170.3728-100000@janus.txd.hvrlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Andi Kleen wrote:
> On Sat, Apr 21, 2001 at 09:21:44PM +0200, Peter Makholm wrote:
> > nagytam@rerecognition.com ("Tamas Nagy") writes:
> > > Idea:
> > > extend the current file-system with an optional plug-in system, which allows
> > > for file-system level encryption instead of file-level.
> >
> > That's is one of the things the loop device offers. For better
> > encryption than XOR you need the patches from kerneli.org.
> No, you don't. The standard kernel loop device supports loading of external
> crypto filters just fine; no patching at all required.

you're right, by using...

int loop_register_transfer(struct loop_func_table *funcs);
int loop_unregister_transfer(int number);

...one can register new transfer functions, but they rely on 'magic
numbers' for identifying the given crypto cipher, some of which are
defined in linux/loop.h; with the highest magic number being MAX_LO_CRYPT
(so patching is required nevertheless, if you want to have more than 20
ciphers by that scheme...)

#define LO_CRYPT_NONE     0
#define LO_CRYPT_XOR      1
#define LO_CRYPT_DES      2
#define LO_CRYPT_FISH2    3    /* Brand new Twofish encryption */
#define LO_CRYPT_BLOW     4
#define LO_CRYPT_CAST128  5
#define LO_CRYPT_IDEA     6
#define LO_CRYPT_DUMMY    9
#define LO_CRYPT_SKIPJACK 10
#define MAX_LO_CRYPT    20

well.... the only thing I don't really like about this is, that its a
static allocation of cipher id's, instead of a dynamic lookup by name
and I'm not sure how well module autoloading works by this scheme...
(the international crypto api offers string lookup for ciphers, and
registers itself as one of those numeric cipher ids as far as loop
device usage is concerned)

btw, there's still an issue with with the IV value being calculated on
varying blocksizes, which I pointed out some time ago (instead of being
calculated on 512 byte sectors, which I assume to be the smallest possible
blocksize settable on a device)

greetings,
-- 
Herbert Valerio Riedel      /     Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F 4142

