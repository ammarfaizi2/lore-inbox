Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265727AbUGHB3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265727AbUGHB3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 21:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUGHB3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 21:29:52 -0400
Received: from lakermmtao12.cox.net ([68.230.240.27]:54160 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S265727AbUGHB3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 21:29:49 -0400
In-Reply-To: <1089226465.862.54.camel@catalepsy.pdl.cmu.edu>
References: <643CA25E-C091-11D8-8574-000393ACC76E@mac.com> <984AC744-BFFB-11D8-8574-000393ACC76E@mac.com> <FC6EBB12-BF27-11D8-95EB-000393ACC76E@mac.com> <1087282990.13680.13.camel@lade.trondhjem.org> <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org> <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com> <87smcxqqa2.fsf@asterisk.co.nz> <8666.1087292194@redhat.com> <10430.1087397355@redhat.com> <30952.1087472906@redhat.com> <5447.1087993789@redhat.com> <D3C62886-C9EE-11D8-947A-000393ACC76E@mac.com> <1089226465.862.54.camel@catalepsy.pdl.cmu.edu>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4B32A85E-D07E-11D8-903F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Blair Strang <bls@asterisk.co.nz>, lkml <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Wed, 7 Jul 2004 21:29:45 -0400
To: John Bucy <bucy@gloop.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 07, 2004, at 14:54, John Bucy wrote:
> (1) processes with different UIDs can share the same keyring EX: I
> have AFS creds (krb5 tickets) and want to run a setuid binary with
> my creds.

This is relatively simple under our proposed system.  Multiple
processes can be attached to a single keyring, and then the access
rights on the keyring control the processes control over it.  Since
keys and keyrings are represented by file descriptors, there are two
ways to gain access to a key/keyring, via a duplicate of the file
descriptor (revokable), or (with sufficient privileges) opening a new
file descriptor using the keyringfs filesystem.

> (2) a number of processes with the same UID can opt not to share
> the same keyring. EX: I want to have a bunch of xterms some with
> administrative rights and some with normal rights.

This is equally easy.  There are several attachment points for keys
and keyrings:
thread
process
process group
session
UID
GID

If you have two processes, and you want to create keys in one that
are inaccessible in the other, then just create a new keyring tied to
the "process" attachment point in the first process, and embed the
original process key-ring in it.  Then you can add administrative
keys to the new keyring, without completely giving up the old one:

EX:
	I am an AFS admin in CELL1, but not in CELL2, and have
different accounts in each.  I have all my process' key-ring pointers
the same, a shared key-ring in which I have my user@CELL1 and
user@CELL2 keys.  Later I decide to do admin work in CELL1,
except I still need access to some of my files in CELL2, so in one
of my shells, I run "key-sh" or something to get a new shell with a
local process key-ring (It has as a child the original shared ring).
Once I have that shell, I can add my CELL1 admin keys normally.
When AFS searches for CELL1 keys it finds them in the topmost
key-ring, stops, and uses the admin ones.  When is searches for
my CELL2 keys, it goes down to the shared key-ring to find them.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


