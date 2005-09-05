Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVIEDmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVIEDmM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 23:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVIEDmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 23:42:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18623 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932138AbVIEDmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 23:42:10 -0400
Date: Mon, 5 Sep 2005 11:47:39 +0800
From: David Teigland <teigland@redhat.com>
To: Greg KH <greg@kroah.com>, joern@wohnheim.fh-wedel.de, arjan@infradead.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050905034739.GA11337@redhat.com>
References: <20050901104620.GA22482@redhat.com> <1125574523.5025.10.camel@laptopd505.fenrus.org> <20050902094403.GD16595@redhat.com> <20050903052821.GA23711@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050903052821.GA23711@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 10:28:21PM -0700, Greg KH wrote:
> On Fri, Sep 02, 2005 at 05:44:03PM +0800, David Teigland wrote:
> > On Thu, Sep 01, 2005 at 01:35:23PM +0200, Arjan van de Ven wrote:
> > 
> > > +	gfs2_assert(gl->gl_sbd, atomic_read(&gl->gl_count) > 0,);
> > 
> > > what is gfs2_assert() about anyway? please just use BUG_ON directly
> > > everywhere
> > 
> > When a machine has many gfs file systems mounted at once it can be useful
> > to know which one failed.  Does the following look ok?
> > 
> > #define gfs2_assert(sdp, assertion)                                       \
> > do {                                                                      \
> >         if (unlikely(!(assertion))) {                                     \
> >                 printk(KERN_ERR                                           \
> >                         "GFS2: fsid=%s: fatal: assertion \"%s\" failed\n" \
> >                         "GFS2: fsid=%s:   function = %s\n"                \
> >                         "GFS2: fsid=%s:   file = %s, line = %u\n"         \
> >                         "GFS2: fsid=%s:   time = %lu\n",                  \
> >                         sdp->sd_fsname, # assertion,                      \
> >                         sdp->sd_fsname,  __FUNCTION__,                    \
> >                         sdp->sd_fsname, __FILE__, __LINE__,               \
> >                         sdp->sd_fsname, get_seconds());                   \
> >                 BUG();                                                    \
> 
> You will already get the __FUNCTION__ (and hence the __FILE__ info)
> directly from the BUG() dump, as well as the time from the syslog
> message (turn on the printk timestamps if you want a more fine grain
> timestamp), so the majority of this macro is redundant with the BUG()
> macro...

Joern already suggested moving this out of line and into a function (as it
was before) to avoid repeating string constants.  In that case the
function, file and line from BUG aren't useful.  We now have this, does it
look ok?

void gfs2_assert_i(struct gfs2_sbd *sdp, char *assertion, const char *function,
                   char *file, unsigned int line)
{
        panic("GFS2: fsid=%s: fatal: assertion \"%s\" failed\n"
              "GFS2: fsid=%s:   function = %s, file = %s, line = %u\n",
              sdp->sd_fsname, assertion,
              sdp->sd_fsname, function, file, line);
}

#define gfs2_assert(sdp, assertion) \
do { \
        if (unlikely(!(assertion))) { \
                gfs2_assert_i((sdp), #assertion, \
                              __FUNCTION__, __FILE__, __LINE__); \
        } \
} while (0)

