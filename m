Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTDUVcz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTDUVcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:32:54 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:41933
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262423AbTDUVcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:32:13 -0400
Message-ID: <3EA4660A.6000506@redhat.com>
Date: Mon, 21 Apr 2003 14:43:38 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030420
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime memory barrier patching
References: <Pine.LNX.4.44.0304211359430.17938-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0304211359430.17938-100000@home.transmeta.com>
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

> They may _work_ for intel, but quite frankly they suck for most Intel (and 
> probably non-intel too) CPU's. Using prefixes tends to almost always mess 
> up the instruction decoders on most CPU's out there.

Indeed, using prefixes is terrible.  This is what is used in gas:


    {0x90};                                     /* nop                  */
  static const char f32_2[] =
    {0x89,0xf6};                                /* movl %esi,%esi       */
  static const char f32_3[] =
    {0x8d,0x76,0x00};                           /* leal 0(%esi),%esi    */
  static const char f32_4[] =
    {0x8d,0x74,0x26,0x00};                      /* leal 0(%esi,1),%esi  */
  static const char f32_5[] =
    {0x90,                                      /* nop                  */
     0x8d,0x74,0x26,0x00};                      /* leal 0(%esi,1),%esi  */
  static const char f32_6[] =
    {0x8d,0xb6,0x00,0x00,0x00,0x00};            /* leal 0L(%esi),%esi   */
  static const char f32_7[] =
    {0x8d,0xb4,0x26,0x00,0x00,0x00,0x00};       /* leal 0L(%esi,1),%esi */
  static const char f32_8[] =
    {0x90,                                      /* nop                  */
     0x8d,0xb4,0x26,0x00,0x00,0x00,0x00};       /* leal 0L(%esi,1),%esi */
  static const char f32_9[] =
    {0x89,0xf6,                                 /* movl %esi,%esi       */
     0x8d,0xbc,0x27,0x00,0x00,0x00,0x00};       /* leal 0L(%edi,1),%edi */
  static const char f32_10[] =
    {0x8d,0x76,0x00,                            /* leal 0(%esi),%esi    */
     0x8d,0xbc,0x27,0x00,0x00,0x00,0x00};       /* leal 0L(%edi,1),%edi */
  static const char f32_11[] =
    {0x8d,0x74,0x26,0x00,                       /* leal 0(%esi,1),%esi  */
     0x8d,0xbc,0x27,0x00,0x00,0x00,0x00};       /* leal 0L(%edi,1),%edi */
  static const char f32_12[] =
    {0x8d,0xb6,0x00,0x00,0x00,0x00,             /* leal 0L(%esi),%esi   */
     0x8d,0xbf,0x00,0x00,0x00,0x00};            /* leal 0L(%edi),%edi   */
  static const char f32_13[] =
    {0x8d,0xb6,0x00,0x00,0x00,0x00,             /* leal 0L(%esi),%esi   */
     0x8d,0xbc,0x27,0x00,0x00,0x00,0x00};       /* leal 0L(%edi,1),%edi */
  static const char f32_14[] =
    {0x8d,0xb4,0x26,0x00,0x00,0x00,0x00,        /* leal 0L(%esi,1),%esi */
     0x8d,0xbc,0x27,0x00,0x00,0x00,0x00};       /* leal 0L(%edi,1),%edi */
  static const char f32_15[] =
    {0xeb,0x0d,0x90,0x90,0x90,0x90,0x90,        /* jmp .+15; lotsa nops */
     0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90};

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+pGYK2ijCOnn/RHQRArJ7AJ4gT4Di95o6wYonrmb+OGvNlbHvvQCfcohZ
nICs/UdZHeqwGs6Y4QJhhAA=
=JZN7
-----END PGP SIGNATURE-----

