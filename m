Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbUAPVnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 16:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUAPVmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 16:42:43 -0500
Received: from ultra12.almamedia.fi ([193.209.83.38]:12723 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S265755AbUAPVmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:42:38 -0500
Message-ID: <40085AF3.C416E39@users.sourceforge.net>
Date: Fri, 16 Jan 2004 23:43:15 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Borgerding <mark@borgerding.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
References: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>		 <4006C665.3065DFA1@users.sourceforge.net> <Pine.GSO.4.58.0401151215320.27227@denali.ccs.neu.edu> <4006F915.370357A9@users.sourceforge.net> <4007EBDA.2060308@borgerding.net> <4007F79C.80A5DE72@users.sourceforge.net> <400818AA.9080009@borgerding.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Borgerding wrote:
> Jari Ruusu wrote:
> > Yep. But that exploit can be used to attack even random passwords up to
> > length of 9 or 10 characters, depending on how much disk space attacker can
> > afford.
> 
> Your point is a good one, although I'd quibble (slightly) on the
> feasibility of that in the near term.
> 
> Even limiting to just 64 possible characters, an 8 character random
> password has 2^48 =~ 2.8e14 combinations. That is getting into the exabyte
> range to handle the ciphertext for a single known plaintext block, much
> less a sector

If you limit 'random' character set to lower case letters and numbers,
storage space requirements are smaller.

You can store first 32...40 bits of the ciphext in file name and ignore the
rest of ciphertext bits. Lets say you put them into file structure like
this:

    /aa/bb/cc/dd/ee 

where aa...ee represent some bits of the ciphertext. Files can be simply
appended with passwords matching those bits. This removes need to store most
of the ciphertext but requires that the few thousand to million passwords be
re-evaluated at attack time.

> >> (How) does your version of aes crypto solve the problems of salt, IVs, &
> >> HMACs?
> >
> > Backward compatibility mode:
> >
> > keybits = hash(password + salt)
> > keybits2 = hash(password_with_bit_flipped + salt)
> > for 1 to n_thousand_iterations {
> >     keybits = AES256_encrypt(keybits2, keybits)
> > }
> >
> > Recommended mode:
> >
> > 64 completely random keys that are encrypted using gpg. gpg encrypted key
> > file stored on removable USB dongle. mount and losetup call gpg to decrypt
> > key file.
> >
> > IV = MD5(all_sector_plaintext_blocks_except_first + 56bits_of_sector_number)
> 
> So you use gpg to encrypt a set of keys that are then used for encrypting
> the filesystem?

Yep.

> Where are the IVs maintained?

IV's are computed at runtime.

If bytes 0...511 represent the 512 bytes of sector, then on encrypt IV is
computed as MD5 of bytes 16...511 of data to write and 56 bits of sector
number in little endian byte order. Then bytes 0...511 are encrypted in
normal CBC mode.

On decrypt, ciphextext of bytes 0...15 is used as IV to decrypt bytes
16...511 in CBC mode. Then MD5 is recompted same way as in encrypt, and
finally bytes 0...15 are decrypted using IV from MD5 computation.

> >> What are the limitations on block size of a loopack device wrt. the
> >> underlying file?
> >
> > I don't recommend file backed loops. Device backed is the way to go.
> 
> Why?

Because file backed loops don't scale well to multiple simultaneous
processes using the loop device. Loop will not begin processing any new
requests until previous one is completely serviced.

There may also be a deadlock issue. If some file system code, holding some
exclusive resource, needs to allocate more RAM (with instructions saying: do
not re-enter any file system), and VM shovels out some dirty pages to free
RAM. File backed loop code may need to re-enter that file system anyway, and
block waiting for that exclusive resource. IOW, one process waits for RAM to
be freed, and loop code waits for some exclusive resource to be freed.
And you have a deadlock.

> > In Linux and many other operating systems, minimum addressable disk unit is
> > 512 byte sector. Each sector must be readable and writable without knowledge
> > of data of other sectors. XFS file system for example appears to write only
> > those 512 byte sectors that actually need writing.
> 
> Another alternative would be to have several file blocks act as a larger block.
> 
> e.g.
> 9 512 byte blocks in a file could become
> 1 4096 byte block in a cryptoloop, with 512 bytes for storage of other stuff.

Yep.

That would make encrypt file system in-place impossible, but that is
not a show stopper limitation.

Atomic one sector writes whould then turn into non-atomic two sector writes,
which may be a problem in some cases.

> BTW, I forgot to do a reply-to-all in my original msg to you. That was not
> intentional. Feel free to reply to this on the list. I did not do so out
> of courtesy.

I added LKML back too CC.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
