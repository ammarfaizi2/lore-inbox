Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTIWW0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbTIWW0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:26:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27309 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263418AbTIWW0e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:26:34 -0400
Date: Tue, 23 Sep 2003 23:26:32 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Deepak Saxena <dsaxena@mvista.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com.br
Subject: Re: [PATCH] Fix %x parsing in vsscanf()
Message-ID: <20030923222632.GO7665@parcelfarce.linux.theplanet.co.uk>
References: <20030923212207.GA25234@xanadu.az.mvista.com> <Pine.LNX.4.44.0309231421450.24527-100000@home.osdl.org> <20030923213533.GN7665@parcelfarce.linux.theplanet.co.uk> <20030923221611.GA25464@xanadu.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923221611.GA25464@xanadu.az.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 03:16:11PM -0700, Deepak Saxena wrote:
>  {
>  	unsigned long result = 0,value;
>  
> +	if ((base == 16) && (cp[0] == '0' && (cp[1] == 'x' || cp[1] == 'X')))
> +		cp += 2;
>  	if (!base) {
>  		base = 10;
>  		if (*cp == '0') {

Not quite right.
	a) on "0xZ" correct reaction is to eat '0' and stop.
	b) while we are at it, might as well fix the case of 0X<...> with
base 0.

The following, AFAICS, would be correct:

        if (*cp == '0') {
                cp++;
                if (unlikely((*cp == 'x' || *cp == 'X') && isxdigit(cp[1]))) {
                        if (!base || base == 16) {
                                cp++;
                                base = 16;
                        }
                } else if (!base)
                        base = 8;
        } else if (!base)
                base = 10;

