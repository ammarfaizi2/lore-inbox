Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVG0Xk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVG0Xk5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVG0Xih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:38:37 -0400
Received: from smtp05.auna.com ([62.81.186.15]:59017 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S261195AbVG0Xgp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:36:45 -0400
Date: Wed, 27 Jul 2005 23:36:38 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] signed char fixes for scripts
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <1121465068l.13352l.0l@werewolf.able.es>
	<1121465683l.13352l.5l@werewolf.able.es>
	<20050727202757.GB31180@mars.ravnborg.org>
In-Reply-To: <20050727202757.GB31180@mars.ravnborg.org> (from
	sam@ravnborg.org on Wed Jul 27 22:27:57 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1122507398l.19829l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.222.145] Login:jamagallon@able.es Fecha:Thu, 28 Jul 2005 01:36:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.27, Sam Ravnborg wrote:
> On Fri, Jul 15, 2005 at 10:14:43PM +0000, J.A. Magallon wrote:
> > 
> > On 07.16, J.A. Magallon wrote:
> > > 
> > > On 07.15, Andrew Morton wrote:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> > > > 
> > 
> > This time I did not break anything... and they shut up gcc4 ;)
> 
> I have applied it to my tree. There still is a lot left when I compile
> with -Wsign-compare.
> 

All the problems are born here:

struct sym_entry {
    unsigned long long addr;
    unsigned int len;
    unsigned char *sym;
};

I suppose you want sym to be an unsigned char to store the type and to do
the checksum math in there.
And why use a 64bit address in 32bit archs ?. There is no math involved
with 'addr', so you can make it a pointer and let the compiler decide its
size.

Why don't you do something like:

struct sym_entry {
    void		*addr;
    unsigned char	type;
    unsigned short	len;
    union {
	unsigned char	data[KSYM_NAME_LEN+1];
	char		name[KSYM_NAME_LEN+1];
    };
};

Option b) is identify the five lines that do the checksum math and plague
them with (unsigned char) casts...
Will try to do it...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam10 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


