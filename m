Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWELTzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWELTzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 15:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWELTzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 15:55:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34970 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751368AbWELTzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 15:55:41 -0400
Message-ID: <4464E83C.7030400@redhat.com>
Date: Fri, 12 May 2006 14:55:40 -0500
From: Clark Williams <williams@redhat.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: script for following Ingo's -rt patches
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------010008040104010009010105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010008040104010009010105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Those of you that follow Ingo's -rt series of patches may find the
attached python script useful. It grew up over time because I wanted
to consistently maintain a local git tree with Ingo's patches.

If you just run the script it will report the latest version of the
- -rt patch found on Ingo's server and then exit.

$ rtpatch
Available RT patch:
    patch-2.6.16-rt21

You can just use it to fetch the patch (rtpatch get), or if you set up
a kernel git tree and tweak a couple of variables in the script, you
can fetch and apply in the same invocation (rtpatch apply). Not sure
the 'apply' option will be of much use to anyone, but it's there if
you want to use it.

Comments welcome.

Clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEZOg7Hyuj/+TTEp0RAlFVAJ4o20nNtIMxFeWoGu0vHsgrDTk69wCdF89C
rOHIyX/nNci58MrjW1u6qGo=
=7JZ4
-----END PGP SIGNATURE-----


--------------010008040104010009010105
Content-Type: text/plain;
 name="rtpatch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtpatch"

#!/usr/bin/python -t
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
# rtpatch - a script to check for existance of, fetch, or fetch and apply the
#           latest of Ingo Molnar's -rt kernel patches
#
# Copyright 2006 Clark Williams <williams@redhat.com>
#

import os, sys
import re
import os.path
import urllib
import HTMLParser

from exceptions import IOError, KeyboardInterrupt, ValueError, Exception

url = "http://people.redhat.com/~mingo/realtime-preempt"
gittree = "linus-kernel.git"
patchdir = "sources"

class FileParser(HTMLParser.HTMLParser):
    def __init__(self):
        HTMLParser.HTMLParser.__init__(self)
        self.seen = {}
    def handle_starttag(self, tag, attributes):
        if tag != 'a': return
        for name, value in attributes:
            if name == 'href' and value not in self.seen:
                self.seen[value] = True
                return


class RTpatchError(Exception):
    def __init__(self, args=None):
        self.args = args


def findpatches():
    try:
        s = urllib.urlopen(url)
    except IOError, e:
        print e
        sys.exit(1)
    except KeyboardInterrupt, e:
        sys.exit(1)
    fp = FileParser()
    while True:
        data = s.read(8192)
        if not data: break
        fp.feed(data)
    s.close()
    patches = []
    for thing in fp.seen.keys():
        if thing.find('patch') >= 0:
            patches.append(thing)
    fp = None
    return patches

def check():
    patches = findpatches()
    if len(patches):
        if len(patches) > 1:
            print "Available RT patches:"
        else:
            print "Available RT patch:"
        for p in patches:
            print "    " + p
    else:
        print "No RT patches found"

def reporter(bcount, bsize, fsize):
    done=bcount * bsize
    percent = float(done) / float(fsize) * 100.0
    if percent > 100.0: percent = 100
    sys.stdout.write('\r  Progress: %3.0f%%' % percent)
    sys.stdout.flush()

def fetch(p):
    try:
        print "Downloading %s" % p
        urllib.urlretrieve("%s/%s" % (url, p), p, reporter)
        sys.stdout.write('\n')
    except KeyboardInterrupt, e:
        print "Aborted"
        pass

def usage():
    print "usage: %s [check|get|apply]" % sys.argv[0]
    print "       running with no arguments checks for existance of the patch"
    sys.exit(-1)

def get_version(patchname):
    r = re.compile(r'^patch-(.+)-rt(\d+)$')
    m = r.match(patchname)
    if m == None:
        print "%s is not a valid realtime patch name" % patchname
        return None
    base = m.group(1)
    ver = m.group(2)
    return (base, ver)

def apply(patch):
    if not os.path.exists(gittree):
        print "Can't find Linux git tree: %s" % gittree
        return
    (base, version) = get_version(p)
    if os.path.exists("%s/.git/refs/heads/v%s-rt%s" % (gittree, base, version)):
        print "patch-%s-rt%s already applied to branch v%s-rt%s" % (base, version, base, version)
        return
    if not os.path.exists("%s/.git/refs/tags/v%s" % (gittree, base)):
        print "can't find base v%s in git tree!" % base
        return
    print "about to apply rt patch %s (based on v%s)" % (version, base)
    # first fetch the patch
    here = os.getcwd()
    os.chdir(patchdir)
    fetch(patch)
    os.chdir(here)
    try:
        os.chdir(gittree)
    except:
        print "Can't cd to git tree %s" % gittree
        return
    # now set up the git tree
    run("git checkout -f")
    run("git branch v%s-rt%s v%s" % (base, version, base))
    run("git checkout v%s-rt%s" % (base, version))
    run("cat %s/sources/%s | patch -p1" % (here, patch))
    run("git add")
    run('git commit -a -m "Ingo\'s %s-rt%s realtime patch"' % (base, version))
    os.chdir(here)
    print "patch %s applied and committed" % patch

def run(cmd):
    print "running: %s" % cmd
    retval = os.system(cmd)
    if retval:
        raise RTpatchError, "%s failed with status %d" % (cmd, retval)
    return

###### Main logic
try:
    cmd = sys.argv[1]
except:
    check()
    sys.exit(1)
    
if cmd == "check":
    check()
elif cmd == "get" or cmd == "fetch":
    patches = findpatches()
    for p in patches:
        fetch(p)
elif cmd == "apply":
    patches = findpatches()
    for p in patches:
        apply(p)
else:
    usage()

--------------010008040104010009010105--
