Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317500AbSHHSPO>; Thu, 8 Aug 2002 14:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317506AbSHHSPN>; Thu, 8 Aug 2002 14:15:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:25009 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317500AbSHHSPL>;
	Thu, 8 Aug 2002 14:15:11 -0400
Date: Thu, 8 Aug 2002 11:21:35 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: driverfs API Updates
In-Reply-To: <20020808134407.18fe4041.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0208080914060.1241-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Aug 2002, Rusty Russell wrote:

> On Mon, 5 Aug 2002 12:17:13 -0700 (PDT)
> Patrick Mochel <mochel@osdl.org> wrote:
> > I've also created a macro[1] for defining device attributes, that goes
> > like this:
> > 
> > DEVICE_ATTR(name,"strname",mode,show,store);
> > 
> > This will create a structure by the name of 'dev_attr_##name', where
> > ##name is the first parameter, which can then be passed to
> > device_create_file(). [2]
> 
> Hi Patrick,
> 	I'll grab 2.5.31 when it comes out and play with it.
> 
> Personally, I would get rid of the "strname" (make it implied by the variable
> name), and use type instead of show & store, eg:

Ok, I updated the macros to drop the "strname" parameter, so they now look 
like this:

DEVICE_ATTR(name,mode,show,store)
BUS_ATTR(name,mode,show,store)
DRIVER_ATTR(name,mode,show,store)

> 	DEVICE_ATTR(frobbable, O_RDWR, int);
> 
> This means you can (1) check that frobbable is actually an int at compile
> time (__check_int), (2) you can use __show_int and __store_int as standard
> routines, and (3) you can use your own types by:
> 
> 	#define __check_frobbable_t(x) ((void)((&x) == (frobbable_t *)0)
> 	/* Define show_frobbable and store_frobbable here */
> 
> 	DEVICE_ATTR(frobbable, O_RDWR, frobbable_t);

We're talking about very similar, though distinctly different attributes. 

The attributes that I've addressed so far are those that are per-object 
and would typically reside in the object's data structure. You want to 
declare one attribute, and expose it for each instance of the object.
The show and store methods have to know which instance you're referring 
to.

'frobbable' above would be a single static variable. show and store could 
only take a pointer to the variable, and could easily use common, shared 
routines. 

With common routines though, you don't get the ability to do object-level 
locking. By defining your own show and store methods, you can. 

That said, this is what I want to do:

Define helpers for parsing and formatting types; e.g. show_int() and
store_int(). Objects' show and store methods can use those for the exposed
attribute.

Support single static attributes by having something like this:

struct int_attribute {
	struct attribute	attr;
	show_int_t		show;
	store_int_t		store;
	int			* data;
};

INT_ATTR(frobbable,0644);

which would produce something like:

int frobbable;
struct int_attr_frobbable = {
	.attr	= {
		.name	= "frobbale",
		.mode	= 0644,
	},
	.show	= show_int,
	.store	= store_int,
};

Then, to expose it to userspace, you would do:

int_attr_create(&int_attr_frobbale);

(or equivalent), and it would then show up in the object's driverfs/kfs 
directory. 

What do you think? It definitely looks a lot like your PARAM stuff, and I 
need to look again at what you wrote to see if I can tie in any more of 
it. 

Of course, they don't have to be exposed to userspace in order to access
them. This is a little further down the road, but by placing them (or
pointers to them) in a special section, we could access attributes at boot
time or module load time, like module parameters. 

And, if we do that, we don't have to have explicit create and remove 
functions to add them to userspace. We can just iterate over the pointers 
at some stage in the boot process or module load time. 

I'm thinking that we could macro-ize locking for single static variables 
as well. We could have something like:

rwlock_t mylock;

INT_ATTR_LOCKED(frobbable,0644,mylock);

which could then generate 

int get_frobbable(void);

void set_frobbable(int val);

as static functions. The show and store methods could either use the lock 
directly, or call back the get/set pair as necessary. I dunno; I haven't 
actually tried to implement that...

	-pat



