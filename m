Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319038AbSHMRRH>; Tue, 13 Aug 2002 13:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319037AbSHMRRH>; Tue, 13 Aug 2002 13:17:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7946 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319038AbSHMRQ6>; Tue, 13 Aug 2002 13:16:58 -0400
Date: Tue, 13 Aug 2002 10:23:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>
Subject: Re: [patch] PCI Cleanup
In-Reply-To: <3D593B37.3070009@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0208131013060.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Matthew Dobson wrote:
>
> I think that it is definitely a simplification, although I am a bit biased ;) 
> It makes it easier for other configuration types to hook into the system as 
> well (I'm partial to NUMA-Q as well ;).  All they have to do is hijack the 
> pci_config_(read|write) function pointers.

Hmm..

Quite frankly, to me it looks like the real issue is that you don't want 
to have the byte/word/dword stuff replicated three times.

And your cleanup avoids the replication, but I think it has other badness 
in it: in particular it depends on those two global pointers. Which makes 
it really hard to have (for example) per-segment functions, or hard for 
drivers to hook into it (there's one IDE driver in particular that wants 
to do conf2 accesses, and nothing else. So it duplicates its own conf2 
functions right now, because it has no way to hook into the generic ones).

If that is the case, wouldn't the _real_ cleanup be to just change the 
format of pci_config_read() entirely, and just make it get the size.

Another way of saying this:

  Right now the config interface is all based around having unique 
  functions for all sizes. So callers do "pci_read_config_word()" and that 
  name-based size calling convention is propagated all the way down.

  Your patch multiplexes the sizes at the lowest level.

  And I'd suggest multiplexing them at a higher level. Instead of 
  six different pcibios_read_config_byte etc functions, move the 
  multiplexing up, make make them just two functions at _that_ level (and 
  make siz #defines to make it compatible with existing users).

Ehh?

		Linus

