Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVCZIZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVCZIZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 03:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVCZIZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 03:25:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:65443 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261749AbVCZIZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 03:25:06 -0500
Subject: Re: 2.6.12-rc1 breaks dosemu
From: Arjan van de Ven <arjan@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       linux-msdos@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200503252354.53154.arnd@arndb.de>
References: <20050320021141.GA4449@stusta.de>
	 <200503251952.33558.arnd@arndb.de>
	 <1111778074.6312.87.camel@laptopd505.fenrus.org>
	 <200503252354.53154.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Mar 2005 09:25:00 +0100
Message-Id: <1111825501.6293.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 23:54 +0100, Arnd Bergmann wrote:
> On Freedag 25 März 2005 20:14, Arjan van de Ven wrote:
> 
> > the randomisation patches came in a series of 8 patches (where several
> > were general infrastructure); could you try to disable the individual
> > randomisations one at a time to see which one causes this effect?
> 
> It's caused by top-of-stack-randomization.patch.
> 

looking at the dosemu code; the following bit looks a tad suspect:

unsigned long int stk_ptr, stk_beg, stk_end;
...
 if ((fp = fopen("/proc/self/maps", "r"))) {
    while(fgets(line, 100, fp)) {
      sscanf(line, "%lx-%lx", &stk_beg, &stk_end);
      if (stk_ptr >= stk_beg && stk_ptr < stk_end) {
        stack_init_top = stk_end;
        stack_init_bot = stk_beg;
        c_printf("CPU: Stack bottom %#lx, top %#lx, esp=%#lx\n",
	  stack_init_bot, stack_init_top, stk_ptr);
	break;
      }
    }
    fclose(fp);
  }

do you see that printf somewhere in the logs? 
(afaics stk_ptr never gets initialized; what the code meant probably was 
 if (&stk_ptr >= stk_beg && &stk_ptr < stk_end) {
but the dosemu code is missing the two &'s )

