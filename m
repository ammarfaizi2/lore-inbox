Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUAJDef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 22:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUAJDee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 22:34:34 -0500
Received: from pop.gmx.net ([213.165.64.20]:13732 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264894AbUAJDed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 22:34:33 -0500
X-Authenticated: #271361
Message-ID: <3FFF72B8.52E6E601@gmx.de>
Date: Sat, 10 Jan 2004 04:34:16 +0100
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: ncunningham@users.sourceforge.net
CC: Andries Brouwer <aebr@win.tue.nl>, root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PATCH 1/2: Make gotoxy & siblings use unsigned variables
References: <1073672901.2069.15.camel@laptop-linux>
	 <Pine.LNX.4.53.0401091415430.571@chaos>
	 <1073677435.2069.23.camel@laptop-linux>
	 <20040109213327.A2699@pclin040.win.tue.nl> <1073683594.4582.36.camel@laptop-linux>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
>
> Andries Brouwer wrote:
>
> > When did you last see a console in text mode with a line length
> > of more than 2^31 ?
> >
> > If you go for a minimal patch then you should replace "char"
> > in one or two places by "unsigned char" and that is all.
>
> Of course you're right about 2^31 columns, but the rest of the code used
> unsigned ints as well, not because it expects 2^31 columns, but because
> (if I understand the code right), the numbers can be part of escape
> sequences... I'm looking at csi_m in vt.c.

Yes, they may be part of escape sequences and that's why your patch is
wrong.  See the comment above gotoxy:

    /*
     * gotoxy() must verify all boundaries, because the arguments
     * might also be negative. If the given position is out of
     * bounds, the cursor is placed at the nearest margin.
    */

If you make the arguments unsigned it will choose the wrong
margin for negative values.  That will i.e. happen if you send
the sequence to move the cursor 10 spaces left when it is only
in column 5.

Afaics, the only thing that needs fixing is putconsxy:

 void putconsxy(int currcons, char *p)
 {
-        gotoxy(currcons, p[0], p[1]);
+        gotoxy(currcons, (unsigned char)p[0], (unsigned char)p[1]);
         set_cursor(currcons);
 }

Ciao, ET.
