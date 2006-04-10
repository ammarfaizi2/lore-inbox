Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWDJCLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWDJCLv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 22:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWDJCLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 22:11:51 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:4775 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1750891AbWDJCLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 22:11:50 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: eCryptfs Design Document
Date: Mon, 10 Apr 2006 02:11:36 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <e1ceso$hac$1@taverner.cs.berkeley.edu>
References: <20060324222517.GA13688@us.ibm.com>
Reply-To: daw-usenet@cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1144635096 17740 128.32.168.222 (10 Apr 2006 02:11:36 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Mon, 10 Apr 2006 02:11:36 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow  wrote:
>eCryptfs v0.1 Design Document

A few comments:

- I don't understand why you are using MD5 in a new design.
  This seems unnecessarily risky.  I do not recommend using MD5 in
  new systems.  Why not use something safer, such as SHA1?

- Like many other disk encryption schemes, this scheme provides no
  integrity protection.  That doesn't matter, if you're only worried about
  passive attackers who can only observe the encrypted content, but if the
  attacker can modify the contents of your encrypted disk (e.g., because
  the encrypted data is stored on a networked filesystem), then you
  need integrity protection.  The threat model doesn't make it entirely
  clear which type of adversary eCryptfs is trying to defend against.
  Section 2 mentions the assumption that the attacker potentially
  has access to every intermediate state but doesn't state whether
  this is just read access, or whether it also includes write access.
  Section 4.4 suggests that the data on disk is outside the control of
  the trusted host environment, which sounds to me like a suggestion
  that the adversary might be able to modify the encrypted data on disk.

- It looks like the scheme has some minor issues with IV reuse.  If I
  understood correctly, when an extent is modified, the IV is not changed,
  and the new data is re-encrypted using the same old data and stored
  on disk.  The problem is that this can occasionally leak information
  about the plaintexts.  For instance, if I encrypt plaintext P, and
  then encrypt modified plaintext P' under the same IV, and if P and P'
  agree in their first k blocks, then the two ciphertexts will also agree
  in their first k blocks.  This allows an adversary who can observe the
  encrypted data on disk both before and after a file write operation
  to tell how many blocks of data at the front of the extent remain
  unchanged by the write operation.  I don't know whether this property
  is acceptable.  It is probably a minor issue at worst.

- The document didn't explain what security advantages this scheme has
  over dmcrypt (if any).

- As you're probably already aware, the use of passphrases to generate
  encryption keys is a potential weak spot in the scheme, because many
  users will probably choose weak passphrases.  This is common to all
  disk encryption schemes I have seen.  The use of iterated hashing is
  a good idea and is about the best you can do.  I'm raising this not
  to suggest that you should do anything different -- I don't have any
  better solutions to this problem -- but just as a reminder that it is
  a potential weak spot.

- I couldn't find any clear specification of the file encryption format.
  This makes it hard to review the security of the scheme.  Presumably if
  I were feeling patient to spend a lot of time on this I could have
  pieced together most or all of the relevant details, but currently the
  document wasn't organized in a way that I could understand.  Is there
  any chance of re-writing this in a way to it easier for cryptographers
  to review?  What would help would be a section that fully specifies how
  to compute the encrypted data as a function of user-visible quantities.
  It would help to have a description that fully specifies all details
  that are cryptographically relevant (such as what modes of operation
  you are using) at a level that can be understood by someone who
  doesn't know anything about Linux kernel internals, but that omits
  implementation details irrelevant to cryptographic analysis (such as the
  name of the data structures in the Linux kernel that you are using).
  What I want to see is the mathematical algorithm, but I don't care
  how it is implemented internally.  Also, the key management is of
  particular interest.

- Once the specification is clarified, I'd encourage you to post this
  where cryptographers hang out.  Sci.crypt and Perry Metzger's
  cryptography mailing list would be two good choices.  There is a chance
  you might get some helpful comments.
