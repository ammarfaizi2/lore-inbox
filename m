Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135443AbRDZOJH>; Thu, 26 Apr 2001 10:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135456AbRDZOI6>; Thu, 26 Apr 2001 10:08:58 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:6584 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S135443AbRDZOIq>; Thu, 26 Apr 2001 10:08:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
Date: Thu, 26 Apr 2001 16:06:53 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10104251804180.3127-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10104251804180.3127-100000@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01042616065300.00884@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 April 2001 00:24, Mark Hahn wrote:
> I have a sense that all of these could be collapsed into a single
> api where kernel systems would register hierarchies of tuples of
> <type,tag,callback>, where callback would be passed the tag,

You also need to know the parent of the tuple to build a hierarchy. And it 
should be possible to create lists. 

The callback prototypes for values could look like this:

int proc_value_cb_string(char *buf, void *context); // writes string to buf, 
// returns len of string or negative value for error
int proc_value_cb_int(int *value, void *context); 


For parent/directory tuples you would provide two additional callbacks that 
set the context for their children and maybe take care of other things like 
locking (so they dont need to be done in every single value callback):

void *proc_value_cb_level_enter(void *old_context); // returns new context
void proc_value_cb_level_leave(void *old_context, void *new_context);


For tuples with a list there would be two callbacks to get the list elements:

int proc_value_cb_list_num(void *context); // returns number of elements
void *proc_value_cb_list_context(int index, void *context); // returns context
// of the element at the given index or NULL


To register such a tuple you would have the following functions:
void proc_value_register_string(parent_handle_t parent, 
                                             const char *name,
		                     proc_value_cb_string cb);
void proc_value_register_int(parent_handle_t parent, 
                                         const char *name,
			     proc_value_cb_int cb);
parent_handle_t proc_value_register_parent(parent_handle_t parent, 
                                  const char *name,
 		          proc_value_cb_level_enter cb1,
		          proc_value_cb_level_leave cb2);
parent_handle_t proc_value_register_list(parent_handle_t h, 
	     	          proc_value_cb_list_num cbnum,
	                      proc_value_cb_list_context cbcon);

This is the simplest API that I can imagine for this. The only problem is 
that you need to write a callback for each value (file). Just printing XML 
still looks easier to me...


> and proc code would take care of "rendering" the data into
> human readable text (default), binary, or even xml.  the latter
> would require some signalling mechanism like O_PROC_XML or the like.

Then you can argue that once you have a single format implemented in the 
kernel you can convert it to whatever you like in user-space. And it seems 
like the decision for "one-value-per-file" in /proc has already been made 
(please correct me if not and we start all over again), so I will try to make 
a generic API like the one above for it.


> further, programs could perform a meta-query, where they ask for
> the types and tags of a datum (or hierarchy), so that on subsequent
> queries, they'd now how to handle binary data.

That would undermine the only advantage of binary data: it's easy (and 
fast) to dump or read a C struct. Not that I would really care for binary 
data...

bye...
