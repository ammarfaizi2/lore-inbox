Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318859AbSHEUMJ>; Mon, 5 Aug 2002 16:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318861AbSHEUMI>; Mon, 5 Aug 2002 16:12:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7082 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318859AbSHEUMH>;
	Mon, 5 Aug 2002 16:12:07 -0400
Date: Mon, 5 Aug 2002 13:17:34 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: driverfs API Updates
In-Reply-To: <Pine.LNX.4.44.0208051438430.2694-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0208051252540.1241-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Aug 2002, Kai Germaschewski wrote:

> On Mon, 5 Aug 2002, Patrick Mochel wrote:
> 
> > [1]: The reason for the macro is because the driverfs internals
> > have changed enough to be able to support attributes of any type. In
> > order to do this in a type-safe manner, we have a generic object type
> > (struct attribute) that we use. We pass this to an intermediate layer
> > that does a container_of() on that object to obtain the specific
> > attribute type. 
> 
> Of course that means that it's not really type-safe, since it has no way 
> to check whether the object is embedded in the right type of struct, right 
> ;) (But I think that's okay, C doesn't have provisions for real 
> inheritance)

Well sure, if you want to get technical. ;) I almost said 'mostly'
type-safe, but I decided I would fib a little to make myself sound
stronger. Basically, I think it's as safe as we can get, and it was 
type-safe enough for Linus..

> > This means the specific attribute types have an embedded struct
> > attribute in them, making the initializers kinda ugly. I played with
> > anonymous structs and unions to have something that could
> > theoretically work, but they apparently don't like named
> > initializers. 
> 
> Have you considered just putting in the embedded part via some macro - 
> I think that's what NTFS does for compilers which don't support unnamed 
> structs.
> 
> Basically
> 
> #define EMB_ATTRIBUTE \
> 	int emb1;
> 	int emb2
> 
> struct my_attribute {
> 	EMB_ATTRIBUTE
> 	int my1;
> 	int my2;
> };

It's not that it's unnamed, it's that we want both object types to exist, 
and have something to do container_of() on. Yet, have something easy to 
declare. 

I wanted something like:

struct attribute {
	char	* name;
	mode_t	mode;
};

struct device_attribute {
	union {
		struct attribute attr;
		struct {
			char	* name;
			mode_t	mode;
	};
	device_show	show;
	device_store	store;
};

You can access struct device_attribute::name fine, except when using named 
initializers. At least with gcc 2.96. 

> That'll work with named initializers just fine, so the users don't have to 
> deal with ugly DEVICE_ATTR macros, where one forgets if parameter #3 was 
> show or store ;) - It follows the common way of hiding away unavoidable 
> ugliness in some header.

Bah, tradeoffs. It's not that hard to get the parameters right; and it 
won't take long for them to notice ;)

> > [2]: I wanted to consolidate the first two parameters, but I couldn't
> > find a way to stringify ##name (or un-stringify "strname"). Is that
> > even possible? 
> 
> Why would stringify (include/linux/stringify.h) not work? However, Al Viro 
> may get mad at you for generating ungreppable symbols either way ;-)

Uhm, because I'm retarded, and I didn't actually try. 


	-pat

