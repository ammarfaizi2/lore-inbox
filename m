Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423251AbWJZKzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423251AbWJZKzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423248AbWJZKzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:55:37 -0400
Received: from main.gmane.org ([80.91.229.2]:39818 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423249AbWJZKze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:55:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: What about make mergeconfig ?
Date: 26 Oct 2006 12:50:51 +0200
Message-ID: <87r6wvjqpg.fsf@willow.rfc1149.net>
References: <1161755164.22582.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Benjamin" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

Benjamin> That would merge all entries in the specified file with the
Benjamin> current .config.

You don't need it to be a Makefile target, it can be an external
script. Would this one (untested!) do what you want?

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

#! /usr/bin/python
#
# (c) 2006 Samuel Tardieu <sam@rfc1149.net>
#
# This software may be used and distributed according to the terms
# of the GNU General Public License, incorporated herein by reference.
#
# Usage: mergeconfig config1 config2 ... > newconfig
#
# To get the formatting back, it is advised to run "make oldconfig" on the
# result.
#
# Be careful in not using the same file as input and output

import sre, sys

_not_set = sre.compile('# (CONFIG_\S+) is not set')
_set = sre.compile('(CONFIG_[^=]+)=(.*)')

def read_config(fn):
    """Read a kernel configuration file and return a dictionary with
    all the options present in the file. If an option is commented out,
    set its value as None."""
    d = {}
    for l in file(fn):
        l = l.rstrip('\r\n')
        x = _not_set.match(l)
        if x: d[x.group(1)] = None
        x = _set.match(l)
        if x: d[x.group(1)] = x.group(2)
    return d

def merge_option(o, v1, v2):
    """Merge option value v1 and v2."""
    if 'y' in [v1, v2]: return 'y'
    if 'm' in [v1, v2]: return 'm'
    if v1 != v2:
        sys.stderr.write('Option %s has two incompatible values: %s and %s' %
                         (o, v1, v2))
        sys.exit(1)
    return v1

def merge_config_into(a, b):
    """Merge configuration dictionary a into configuration dictionary b.
    In addition, this function returns b after the merge."""
    for k, v in a.items():
        try:
            b[v] = merge_option(k, v, b[v])
        except KeyError:
            b[k] = v
    return b

def output_config(d):
    for k, v in d.items():
        if v is None: print '# %s is not set' % k
        else: print '%s=%s' % (k, v)

if __name__ == '__main__':
    output_config (reduce(lambda x, y: merge_config_into(x, read_config(y)),
                          sys.argv[1:], {}))

