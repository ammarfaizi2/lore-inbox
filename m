Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTGFQT3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbTGFQT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:19:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48870 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262578AbTGFQTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:19:22 -0400
Date: Sun, 6 Jul 2003 17:33:53 +0100
From: Matthew Wilcox <willy@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: kobjects, sysfs and the driver model make my head hurt
Message-ID: <20030706163353.GU23597@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's just all too complex.  There's just too many levels of indirection
and structures which do almost the same thing and misleading functions.
It needs to be thoroughly simplified.  Here's one particularly misleading
function:

/**
 *      kobject_get - increment refcount for object.
 *      @kobj:  object.
 */

struct kobject * kobject_get(struct kobject * kobj)
{
        struct kobject * ret = kobj;

        if (kobj) {
                WARN_ON(!atomic_read(&kobj->refcount));
                atomic_inc(&kobj->refcount);
        } else
                ret = NULL;
        return ret;
}

Why on earth does it return the value of its argument?  And why's it
written in such a convoluted way?  Here's a simpler form which retains
all the existing semantics:

struct kobject * kobject_get(struct kobject * kobj)
{
	if (kobj) {
		WARN_ON(!atomic_read(&kobj->refcount));
		atomic_inc(&kobj->refcount);
	}
	return kobj;
}

or maybe better:

{
	if (!kobj)
		return NULL;
	WARN_ON(!atomic_read(&kobj->refcount));
	atomic_inc(&kobj->refcount);
	return kobj;
}

But why return anything?  Which looks clearer?

(a)	kobj = kobject_get(kobj);

(b)	kobject_get(kobj);

The first one makes me think that kobject_get might return a different
kobject than the one I passed in.  That doesn't make much sense.

There's much more in this vein, but this email is long enough already.

<rmk> "you are in a maze of structures, all alike.  There is a kset here."

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
