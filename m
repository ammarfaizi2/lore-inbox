Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264491AbTEPQd1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 12:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTEPQd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 12:33:27 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:21633 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264491AbTEPQdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 12:33:25 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 May 2003 18:45:41 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-fbdev-devel] Re: [BK FBDEV] String drawing optim
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jsimmons@infradead.org
X-mailer: Pegasus Mail v3.50
Message-ID: <1AFB79A034C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 May 03 at 10:24, Geert Uytterhoeven wrote:
> On Thu, 15 May 2003, James Simmons wrote:
> > > What about getting rid of one-char putc, implementing it in terms of
> > > putcs? I'm doing it in matroxfb patches, and nobody complained yet, and
> > > with current length of {fbcon,accel}_putc{s,} I was not able to find
> > > measurable speed difference between putc and putc through putcs variants.
> > 
> > Hm. I compressed all the image drawing functions into accel_putcs which is 
> > used in many places. I then placed accel_putc() into fbcon_putc(). I could 
> > have accel_putcs() called in fbcon_putc(). The advantage is smaller 
> > amount of code. The offset is a big more overhead plus a function call. 
> > What do people think here?
> 
> putc() is almost never called, IIRC. We did our best to combine as much data as
> possible and call putcs().
> 
> A quick grep showed ->con_putc() is called only in drivers/char/vt.c for:
>   - Complementing the pointer position (for gpm)
>   - Inserting/deleting single characters
>   - Softcursor

Insert and Delete char are especially funny, as they do:

scr_memsetw(p, video_erase_char, nr * 2);
...
attr = video_erase_char >> 8;
while (nr--) {
   sw->con_putc(vc_cons[currcons].d,
                video_erase_char, y,
                video_num_columns-1-nr);
}
attr = oldattr;

so we can turn whole loop into one single putcs() call, asking
for painting 'nr' characters from 'p' at y,video_num_columns-nr, 
which will definitely help... And I believe that vc's attr is not 
used by putc/putcs anymore, we always pass color explicit (in upper 
bits of character).
                                                    Petr Vandrovec
                                                    

