Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261649AbSIXLaa>; Tue, 24 Sep 2002 07:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261650AbSIXLaa>; Tue, 24 Sep 2002 07:30:30 -0400
Received: from [217.167.51.129] ([217.167.51.129]:41945 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261649AbSIXLa2>;
	Tue, 24 Sep 2002 07:30:28 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Richard Zidlicky" <rz@linux-m68k.org>,
       "Andre Hedrick" <andre@linux-ide.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE janitoring comments
Date: Tue, 24 Sep 2002 13:35:35 +0200
Message-Id: <20020924113535.11318@192.168.4.1>
In-Reply-To: <20020924112732.B1060@linux-m68k.org>
References: <20020924112732.B1060@linux-m68k.org>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I need different transfer functions depending on whether drive
>control data(like IDENT,SMART) or HD sectors are to be transfered. 
>Control data requires byteswapping to correct bus-byteorder
>whereas sector r/w has to be raw for compatibility.
>
>So that will require 2 additional iops pointers and some change
>in ide_handler_parser or ide_cmd_type_parser to select the
>appropriate version depending on the drive command.

No, it doesn't. There are already separate iops for control
and datas, typically {in,out}{b,w,l} are for control (though
only "b" versions are really useful and {in,out}s{b,w,l} are
for datas.

There are cases where ide_{input,output}_data my try to
"re-invent" the "s" functions with a loop of non-s ones,
but you shouldn't have to care about that case. It might
actually work for you because of your weird wiring, but it's
definitely broken for other BE archs, and so drive->slow
shouldn't be set on anything but x86.

Actually, the whole set of iops could probably be shrunk
down to just {in,out}b for control and {in,out}s{w,l} for
datas. Though we probably want, ultimately, to change that
to some different (higher level ?) kind of abstraction.

Ben.


