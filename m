Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314328AbSEHOCW>; Wed, 8 May 2002 10:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314330AbSEHOCV>; Wed, 8 May 2002 10:02:21 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:20744 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314328AbSEHOCU>;
	Wed, 8 May 2002 10:02:20 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrey Panin <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] __init and friends support for loadable modules 
In-Reply-To: Your message of "Wed, 08 May 2002 14:29:33 +0400."
             <20020508102933.GA574@pazke.ipt> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 May 2002 00:02:07 +1000
Message-ID: <9276.1020866527@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002 14:29:33 +0400, 
Andrey Panin <pazke@orbita1.ru> wrote:
>attached patch adds support for	freeing .init sections of loadable modules
>after init_module() function exits. Modutils have support for this since 19=
>98,
>but kernel support didn't exist.

The main reason I have not done this myself is the interaction between
freeing code areas and the exception and unwind tables.  When you free
code, you should remove or nullify the related unwind and exception
entries.  Another module could be loaded into the area that used to
contain init code and it would then be mapped by the first module's
tables, oops.

Fixing exception tables is relatively easy, search_exception_table()
can check if the address fits within the module (taking runsize into
account) before running the exception table.  Unwind data is harder, it
is all architecture specific.  Your patch will not be complete without
fixing all tables that point at module code.  Don't forget the MIPS DBE
table.

Rusty and I plan to completely redo module loading and unloading and
the corresponding modutils support in 2.5.  That will (hopefully)
include additional features such as per-node replication of pure module
areas for NUMA boxes.  For me, the ability to free .init text and data
from modules falls into the category of "would be nice but the gain is
not worth the bother just for 2.4".

