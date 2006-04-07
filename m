Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWDGOaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWDGOaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWDGOaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:30:06 -0400
Received: from palrel13.hp.com ([156.153.255.238]:41187 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S932255AbWDGOaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:30:04 -0400
Date: Fri, 7 Apr 2006 10:30:02 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: linux-kernel@vger.kernel.org
Cc: John McCutchan <john@johnmccutchan.com>, Robert Love <rlove@rlove.org>
Subject: Re: [RFC][PATCH] inotify kernel api
Message-ID: <20060407143002.GA28009@zk3.dec.com>
References: <20060406170601.GA22698@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406170601.GA22698@zk3.dec.com>
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 01:06:01PM -0400, Amy Griffis wrote:
> The following patch against 2.6.17-rc1-mm1 introduces a kernel API
> for inotify.

I realized that my first email assumed quite a bit of knowledge about
inotify.  Here is a description of the interface I'm proposing.

Each inotify instance is represented by an inotify_handle structure.
For the inotify consumer supplying support to userspace, each
inotify_device has an associated inotify_handle.

Each inotify watch is represented by an inotify_watch structure.
Watches are chained off of each associated inode and inotify_handle.

Using the Inotify Kernel Interface
----------------------------------
First you must initialize an inotify instance.

    struct inotify_handle *ih = inotify_init(my_event_handler);

You are given an opaque inotify_handle, which you use for any further calls to
inotify.  You provide a function to be called to process events on your
registered watches.  

    void my_event_handle(struct inotify_watch *iwatch, u32 wd, u32 mask,
			 u32 cookie, const char *name, struct inode *inode)

    iwatch - the pointer to the inotify_watch that triggered this call
    wd - the watch descriptor
    mask - describes the event that occurred
    cookie - an identifier for synchronizing events
    name - the dentry name for affected files in a directory-based event
    inode - the affected inode in a directory-based event

You may add watches by providing a pre-allocated inotify_watch structure and
specifying the inode to watch along with an inotify event mask.  You must pin
the inode during the call.  You will likely wish to embed the inotify_watch
structure in a structure of your own which contains other information about the
watch.

    s32 wd = inotify_add_watch(ih, &my_watch->iwatch, inode, mask);

You may use the watch descriptor (wd) or the address of the inotify_watch for
other inotify operations.  You must not directly read or manipulate data in the
inotify_watch.  Additionally, you must not call inotify_add_watch() more than
once for a given inotify_watch structure, unless you have first called either
inotify_rm_watch() or inotify_rm_wd().

To determine if you have already registered a watch for a given inode, you may
call inotify_find_watch(), which gives you both the wd and the watch pointer for
the inotify_watch, or an error if the watch does not exist.

    wd = inotify_find_watch(ih, inode, &watchp);

You may use container_of() on the watch pointer to access your own data
associated with a given watch.

Call inotify_find_update_watch() to update the event mask for an existing watch.
inotify_find_update_watch() returns the wd of the updated watch, or an error if
the watch does not exist.

    wd = inotify_find_update_watch(ih, inode, mask);

An existing watch may be removed by calling either inotify_rm_watch() or
inotify_rm_wd().

    int ret = inotify_rm_watch(ih, &my_watch->iwatch);
    int ret = inotify_rm_wd(ih, wd);

Call inotify_destroy() to remove all watches from your inotify instance and
release it.

    inotify_destroy(ih);

When inotify removes a watch, it sends an IN_IGNORED event to your callback.
You may use this event as an indication to free the watch memory.  Note that
inotify may remove a watch due to filesystem events, as well as by your request.


Function Prototypes
-------------------
struct inotify_handle *inotify_init(void (*cb)(struct inotify_watch *,
					       u32, u32, u32, const char *,
					       struct inode *))

s32 inotify_add_watch(struct inotify_handle *ih, struct inotify_watch *watch,
                      struct inode *inode, u32 mask)

s32 inotify_find_watch(struct inotify_handle *ih, struct inode *inode,
                       struct inotify_watch **watchp)

s32 inotify_find_update_watch(struct inotify_handle *ih, struct inode *inode,
                              u32 mask)

int inotify_rm_wd(struct inotify_handle *ih, u32 wd)

int inotify_rm_watch(struct inotify_handle *ih, struct inotify_watch *watch)

void inotify_destroy(struct inotify_handle *ih)
