Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbSLNNnl>; Sat, 14 Dec 2002 08:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbSLNNnl>; Sat, 14 Dec 2002 08:43:41 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:33806 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267611AbSLNNnj>; Sat, 14 Dec 2002 08:43:39 -0500
Date: Sun, 15 Dec 2002 00:51:25 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: linux-kernel@vger.kernel.org
cc: "David S. Miller" <davem@redhat.com>,
       cryptoapi-devel <cryptoapi-devel@kerneli.org>
Subject: [RFC] Hardware support notes for the kernel crypto API (2.5+)
Message-ID: <Mutt.LNX.4.44.0212150025190.24712-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below are some initial notes on hardware support for the kernel crypto
API, discussing some initial requirements, vendor documentation status,
GPL driver status, and pointers to resources and earlier discussions on
the topic.

The focus at the moment is on gathering the requirements for generic
hardware crypto devices, which can be used to assist kernel components
(e.g. IPsec, CIFS), and userspace applications (e.g. SSL, IKE).  Some work 
has begun on obtaining documentation from vendors and developing clean GPL 
drivers.

Comments welcome, please consider following up to cryptoapi-devel for 
ongoing discussion.

(This document is also maintained at http://samba.org/~jamesm/crypto/)

------------------------------------------------------------------------------
Linux Kernel Crypto API - Hardware Support Notes
Last updated 15 Dec 2002
------------------------------------------------------------------------------

Requirements
  
  - Crypto hardware will require an asynchronous API with callbacks via
    softirq.
    
  - Multiple card support:
      Request dispatcher, needs to ensure requests are balanced
      across cards.
      
      Allow parallel operation for the same session: need to
      reserve session across all boards and dispatch appropriately.

  - Request dispatcher therefore required, and must have knowledge
    of cards: session support, session id format, algorithms, 
    batching capability, SG support etc.
  
  - Driver might be passed a logical request from the dispatcher
    in the form of:
      
      command = {operation, context, source, destination}
    
    How to handle scatter/gather?

      command = { operation, context, source sg, destination sg}
  
    If the card supports batching, multiple commands may be grouped:
    
      { command, command, command, ... }

  - How to handle card / queue full? (top level API change: all operations
    can fail).  Fall back to software? (async api will be required to
    support software implementations as well).

  - Pipeline management (where appropriate).
  
  - How to support IPsec offload to onboard NIC?
  
  - What will the Kernel & Userspace APIs look like?
  
    Kernel:
      crypto_alloc_tfm() - current simple interface
      crypto_alloc_session() - batching of commands, IPsec offload[?] etc.
                               specify algorithm bundle, preferences, then
                               use api helpers to build and send dispatcher
                               requests.

    Userspace:
      cryptoapifs? (see
      http://www.kerneli.org/pipermail/cryptoapi-devel/2002-December/000320.html)
    
  - Asymmetric crypto?

  - Existing kernel APIs with hardware support:
    - OpenBSD crypto queue
    - Cryptolib by Martin Gadbois,
      http://sources.colubris.com/en/projects/FreeSWAN/
      (what license does cryptolib use?)
    
  - Other discussions/proposals/code:
    - Michael Richardson
      http://mail.nl.linux.org/linux-crypto/2002-07/msg00054.html
      (also see followup threads on cryptoapi-devel)
    - Bart Trojanowski's Generic Engine
      http://www.jukie.net/~bart/genericengine/
      

Hardware documentation status:

  HiFn
    Documentation for Hifn cards available via download at their web site.
  
  IBM
    Can provide driver source for the card, and some general documentation is
    available at http://www.ibm.com/security/cryptocards/
    Software development toolkit is export controlled (contact IBM for more
    info).
    
  Motorola
    Unknown (Steve is working on some Linux drivers though).
    
  Intel
    Crypto documentation for NICs unavailable.
    
  3COM
    Crypto documentation for NICs unavailable.
    
  Broadcom
    No response to emails.
    
  AEP/Baltimore
    Unknown (not contacted yet, Linux driver available).
    
  Corrent
    Unknown (not contacted yet).
   
  Eracom
    Contacted some time ago, documentation had to be purchased (expensive).
    Not sure if this has changed.
    
  Safenet
    Unknown (not contacted yet).  
  

GPL Driver status:

  HiFn 7751
    James Morris (in progress).
  
  HiFn 7951
    David Bryson (in progress).
    Also see http://sourceforge.net/projects/hifn7951/
  
  HiFn 7901
    See http://sources.colubris.com/en/projects/FreeSWAN/
    
  Motorola MPC190, MPC184
    Steve (in progress).
    
  IBM 4758
    Available from IBM on request.

  AEP paep
    A dual licensed GPL/BSD driver is available somewhere.


Summary:
   I don't think we have enough documentation yet, notably none for NICs
   with crypto hardware.

------------------------------------------------------------------------------


- James
--
James Morris
<jmorris@intercode.com.au>


