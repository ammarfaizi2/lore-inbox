Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268033AbRGVSxz>; Sun, 22 Jul 2001 14:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268040AbRGVSxq>; Sun, 22 Jul 2001 14:53:46 -0400
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:17670 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S268033AbRGVSxk>; Sun, 22 Jul 2001 14:53:40 -0400
Date: Sun, 22 Jul 2001 20:53:50 +0200 (CEST)
From: Herbert Valerio Riedel <hvr@hvrlab.org>
X-X-Sender: <hvr@janus.txd.hvrlab.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: Re: RFC: block/loop.c & crypto
In-Reply-To: <20010722170313.B30813@athlon.random>
Message-ID: <Pine.LNX.4.33.0107222031390.3517-100000@janus.txd.hvrlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

hi

On Sun, 22 Jul 2001, Andrea Arcangeli wrote:
> On Sun, Jul 22, 2001 at 12:21:30PM +0200, Herbert Valerio Riedel wrote:
> > some months ago, when I proposed to switch IV calculation completely to
> > fixed a fixed 512 byte blocksize, I was reminded, that the international
> > crypto patch was not the only one to make use of the IV calculatiion, and
> > doing so would break other crypto packages around...
> >
> > ...so I suggested that I'd try a more backward compatible approach, which
> > would allow old packages to retain compatibility, and new packages aware
> > of the new flag to set IV calculation to 512 byte blocks...
> > well the result of this experiment can be seen in the attachment...
> >
> > so... any comments?
>
> -               int IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
> +               unsigned long IV = loop_get_iv(lo, (pos - lo->lo_offset) >> LO_IV_SECTOR_BITS);
> +
>                 size = PAGE_CACHE_SIZE - offset;
> 		^^^^
> it's more complicated than that.
>
> If you want to change the IV every 512bytes you must as well reduce the
> underlined size and recalculate the IV or it won't do what you are
> expecting. Same fixup of the logic is needed for even the blkdev backed
> I/O (you can't use the same IV for the whole b_size anymore)

I haven't told you how the cryptoloop.c module contains the necessary
logic... :-)

static int
transfer_cryptoapi(struct loop_device *lo, int cmd, char *raw_buf,
                   char *loop_buf, int size, int real_block)
{
  struct cipher_context * cx = (struct cipher_context *) lo->key_data;
  struct cipher_implementation *ci = cx->ci;
  int (*encdecfunc)(struct cipher_context *cx, const u8 *in, u8 *out,
                    int size, const u32 iv[]);
  char *in, *out;

  if (cmd == READ) {
#if defined(CRYPTOLOOP_ATOMIC)
    encdecfunc = ci->decrypt_atomic;
#else
    encdecfunc = ci->decrypt;
#endif
    in = raw_buf;
    out = loop_buf;
  } else {
#if defined(CRYPTOLOOP_ATOMIC)
    encdecfunc = ci->encrypt_atomic;
#else
    encdecfunc = ci->encrypt;
#endif
    in = loop_buf;
    out = raw_buf;
  }

#if defined(USE_LO_IV_MODE_SECTOR)
#warning USE_LO_IV_MODE_SECTOR enabled -- hope you know what this means
  /* split up transfer request into 512 byte data blocks */
  while (size > 0) {
    int _size = (size > LO_IV_SECTOR_SIZE) ? LO_IV_SECTOR_SIZE : size;
    u32 iv[4] = { 0, };

    iv[0] = cpu_to_le32 (real_block);
    encdecfunc (cx, in, out, _size, iv);

    real_block++;
    size -= _size;
    in += _size;
    out += _size;
  }
#else
  {
    u32 iv[4] = { 0, };
    iv[0] = cpu_to_le32 (real_block);
    encdecfunc (cx, in, out, size, iv);
  }
#endif

  return 0;
}


> I believe the main reason we are using the softblocksize of the device
> instead of 512bytes is just because it made strightforward the above
> issues. Of course performance will decrease somehow this way.

well that's in part why I left the size untouched, and moved the logic to
the transfer function, that way if we have some means to optimize larger
transfers (maybe because we don't make use at all of the IV so we don't
need 512 byte chunks but can handle bigger ones w/o problems...)

> OTOH the advantage I can see in your change is that the cryptoloop won't
> break across a change of the softblocksize if the crypto plugin is using
> the IV (like mkfs -b 4096 writing with an IV at 1k and then ext2 reading
> with an IV of 4k). Actually if we make this change I believe breaking
> backwards compatibility and making it the default could be a good thing,
> any crypto plugin depending on the current IV calculation is just
> subject to be not completly functional. Furthmore if we make this change

that's especially true for filesystems which change the blocksize
frequently; e.g. XFS uses different blocksizes, since it has different
sections which get accessed with different blocksizes...

> to the IV cryptoloop API, I'm wondering if we really need to make the
> default 512bytes and not 1k, if we make the fixed IV granularity 1k then
> all current drivers should keep working fine because the mkfs always
> defaults to 1k the first time (performance will be better too). Not sure
> about the lack of security of having the double number of bits sharing
> the same IV but I assume that wasn't the reason of the change.

security is not the issue; it's more of practical terms... since 512 byte
seems to be the closest practical transfer size (there isn't any smaller
blocksize supported with linux) it seems natural to use that one....

best regards,
-- 
Herbert Valerio Riedel       /    Phone: (EUROPE) +43-1-58801-18840
Email: hvr@hvrlab.org       /    Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F 4142

