Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266183AbSLOBPj>; Sat, 14 Dec 2002 20:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbSLOBPi>; Sat, 14 Dec 2002 20:15:38 -0500
Received: from CPE-203-51-35-111.nsw.bigpond.net.au ([203.51.35.111]:12794
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S266183AbSLOBPh>; Sat, 14 Dec 2002 20:15:37 -0500
Message-ID: <3DFBD98E.53E9D8BB@eyal.emu.id.au>
Date: Sun, 15 Dec 2002 12:23:26 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: rmap and nvidia?
References: <1039858571.559.15.camel@nirvana>  <20021214093831.GL9882@holomorphy.com>
	 <1039859196.771.18.camel@nirvana> <Pine.LNX.4.50L.0212141225320.32283-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sat, 14 Dec 2002, mdew wrote:
> > On Sat, 2002-12-14 at 22:38, William Lee Irwin III wrote:
> > > On Sat, Dec 14, 2002 at 10:36:10PM +1300, mdew wrote:
> > > > nv.c: In function `nv_get_phys_address':
> > > > nv.c:2182: warning: implicit declaration of function `pte_offset'
> > > > nv.c:2182: invalid type argument of `unary *'
> > >
> > > Use pte_offset_map() with a corresponding pte_unmap().
> >
> > err pardon?
> 
> wli just gave you the information you need to create a patch
> for the nvidia driver.

The replies for people in the know (Rik, wli) give a clue but not an
answer. Use mere mortals want a proper patch in order to build and
use this kernel.

I will summarise my understanding so far; The original code says:

unsigned long
nv_get_phys_address(unsigned long address)
{
    pgd_t *pg_dir;
    pmd_t *pg_mid_dir;
    pte_t *pte__, pte;
.....
#if defined (pte_offset_atomic)
    pte__ = pte_offset_atomic(pg_mid_dir, address);
    pte = *pte__;
    pte_kunmap(pte__);
#else
    pte__ = NULL;
    pte = *pte_offset(pg_mid_dir, address);
#endif

    if (!pte_present(pte))
        goto failed;

    return ((pte_val(pte) & KERN_PAGE_MASK) | NV_MASK_OFFSET(address));
.....
}

The last line above is the problem. So far I could see two possible
changes that will compile, but I do not know which will function
correctly. The first replacement option:
    pte = *pte_offset(pg_mid_dir, address);

The second replacement option is more involved:
    pte__ = pte_offset_map(pg_mid_dir, address);
    pte = *pte__;

    if (!pte_present(pte))
        goto failed;

    pte_unmap(pte__);

Reading the patch itself I see places where the first approach is used,
while elsewhere the second is used. I do not know what pte_val(pte)
requires though. Can we do the pte_unmap(pte__) earlier or is the
mapping
necessary for pte_present(pte)? Will this work:
    pte__ = pte_offset_map(pg_mid_dir, address);
    pte = *pte__;
    pte_unmap(pte__);


In summary, you can see that for someone who is not intimately involved
the answers so far do not provide a working patch.

Thanks everybody.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
