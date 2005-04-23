Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVDWM7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVDWM7z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 08:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDWM7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 08:59:55 -0400
Received: from mail.portrix.net ([212.202.157.208]:41192 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261571AbVDWM6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 08:58:48 -0400
Message-ID: <426A4669.7080500@ppp0.net>
Date: Sat, 23 Apr 2005 14:58:17 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050116 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Git-commits mailing list feed.
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>
In-Reply-To: <20050422002922.GB6829@kroah.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040006070901080706010700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040006070901080706010700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Thu, Apr 21, 2005 at 08:24:36AM +0200, Jan Dittmer wrote:
> 
>>David Woodhouse wrote:
>>
>>>As of some time in the fairly near future, the bk-commits-head@vger mailing 
>>>list will be carrying real commits from Linus' live git repository, instead
>>>of just testing patches. Have fun.
>>>
>>
>>What about the daily snapshots? Is there any eta when they'll be back?
> 
> 
> The script that generated this was posted previously on lkml.  If anyone
> wants to hack that up to generate the snapshots, it would be greatly
> appreciated.

I didn't found above mentioned post, so I hacked up a cruel script
myself. It relies on ketchup (www.selenic.com/ketchup)
to retrieve the current base version. Also it requires git's
`checkout-cache --prefix=` to work properly.
On the top of the script are some basic configuration parameters.
No signing etc. is done. The script should be fairly robust - though
I wouldn't try to run it as root ;-).
Sample output can be found here: http://l4x.org/kernelgit/ .
I attach the script and a modified ketchup version which allows retrieval
of these snapshots from above mentioned url. So `ketchup 2.6-git` gives
you the latest version.
The produced patch will create a file git-commit-id in the top-level
directory with the commit id used to create the patch.
Hope it helps - otherwise you could still point me to the post you
mentioned.

-- 
Jan


--------------040006070901080706010700
Content-Type: text/plain;
 name="ketchup"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ketchup"

#!/usr/bin/python
#
# ketchup v0.9-pre "self-contained corner case"
# http://selenic.com/ketchup/
#
# Copyright 2004 Matt Mackall <mpm@selenic.com>
#
# This software may be used and distributed according to the terms
# of the GNU General Public License, incorporated herein by reference.
#
# Usage:
#
# in an existing kernel directory, run:
# 
#  ketchup <version>
#
# where version is a complete kernel version, or a branch name to grab
# the latest version

import re, sys, urllib, os, getopt, glob

def error(*args):
    sys.stderr.write("ketchup: ")
    for a in args:
        sys.stderr.write(str(a))
        sys.stderr.write("\n")

def fancyopts(args, options, state, syntax=''):
    long=[]
    short=''
    map={}
    dt={}

    def help(state, opt, arg, options=options, syntax=syntax):
        print "Usage: ", syntax

        for s, l, d, c in options:
            opt=' '
            if s: opt = opt + '-' + s + ' '
            if l: opt = opt + '--' + l + ' '
            if d: opt = opt + '(' + str(d) + ')'
            print opt
            if c: print '   %s' % c
        sys.exit(0)

    if len(args) == 0:
        help(state, None, args)

    options=[('h', 'help', help, 'Show usage info')] + options
    
    for s, l, d, c in options:
        map['-'+s] = map['--'+l]=l
        state[l] = d
        dt[l] = type(d)
        if not d is None and not type(d) is type(help): s, l=s+':', l+'='      
        if s: short = short + s
        if l: long.append(l)

    if os.environ.has_key("KETCHUP_OPTS"):
        args = os.environ["KETCHUP_OPTS"].split() + args

    try:
        opts, args = getopt.getopt(args, short, long)
    except getopt.GetoptError:
        help(state, None, args)
        sys.exit(-1)

    for opt, arg in opts:
        if dt[map[opt]] is type(help): state[map[opt]](state,map[opt],arg)
        elif dt[map[opt]] is type(1): state[map[opt]] = int(arg)
        elif dt[map[opt]] is type(''): state[map[opt]] = arg
        elif dt[map[opt]] is type([]): state[map[opt]].append(arg)
        elif dt[map[opt]] is type(None): state[map[opt]] = 1
        
    return args

try: kernel_url = os.environ["KETCHUP_URL"]
except: kernel_url = 'http://www.kernel.org/pub/linux/kernel'

try: archive = os.environ["KETCHUP_ARCH"]
except: archive = os.environ["HOME"] + "/.ketchup"

wget = "/usr/bin/wget"
if not os.path.exists(wget): wget = ""

gpg = "/usr/bin/gpg"
if not os.path.exists(gpg): gpg = ""

options = {}
opts = [
    ('a', 'archive', archive, 'cache directory'),
    ('d', 'directory', '.', 'directory to update'),
    ('f', 'full-tarball', None, 'if unpacking a tarball, download the latest'),
    ('g', 'gpg-path', gpg, 'path for GnuPG'),
    ('G', 'no-gpg', None, 'disable GPG signature verification'),
    ('k', 'kernel-url', kernel_url, 'base url for kernel.org mirror'),
    ('l', 'list-trees', None, 'list supported trees'),
    ('m', 'show-makefile', None, 'output version in makefile <arg>'),
    ('n', 'dry-run', None, 'don\'t download or apply patches'),
    ('p', 'show-previous', None, 'output version previous to <arg>'),
    ('q', 'quiet', None, 'reduce output'),
    ('r', 'rename-directory', None, 'rename updated directory to linux-<v>'),
    ('s', 'show-latest', None, 'output the latest version of <arg>'),
    ('u', 'show-url', None, 'output URL for <arg>'),
    ('w', 'wget', wget, 'command to use for wget'),
    ]

args = fancyopts(sys.argv[1:], opts, options,
                 'ketchup [options] <ver>')

archive = options["archive"]
kernel_url = options["kernel-url"]
if options["no-gpg"]: options["gpg-path"] = ''

def qprint(*args):
    if not options["quiet"]:
        sys.stdout.write(" ".join(map(str, args)))
        sys.stdout.write("\n")

# Functions to parse version strings

def tree(ver):
    return float(re.match(r'(\d+\.\d+)', ver).group(1))

def rev(ver):
    p = pre(ver)
    r = int(re.match(r'\d+\.\d+\.(\d+)', ver).group(1))
    if p: r = r - 1
    return r

def pre(ver):
    try: return re.match(r'\d+\.\d+\.\d+(\.\d+)?-((rc|pre)\d+)', ver).group(2)
    except: return None

def post(ver):
    try: return re.match(r'\d+\.\d+\.\d+\.(\d+)', ver).group(1)
    except: return None

def pretype(ver):
    try: return re.match(r'\d+\.\d+\.\d+(\.\d+)?-((rc|pre)\d+)', ver).group(3)
    except: return None

def prenum(ver):
    try: return int(re.match(r'\d+\.\d+\.\d+-((rc|pre)(\d+))', ver).group(4))
    except: return None

def prebase(ver):
    return re.match(r'(\d+\.\d+\.\d+((-(rc|pre)|\.)\d+)?)', ver).group(1)

def revbase(ver):
    return "%s.%s" % (tree(ver), rev(ver))

def base(ver):
    v = revbase(ver)
    if post(ver): v += "." + post(ver)
    return v

def forkname(ver):
    try: return re.match(r'\d+.\d+.\d+(\.\d+)?(-(rc|pre)\d+)?(-(\w+?)\d+)?',
                         ver).group(5)
    except: return None

def forknum(ver):
    try: return int(
        re.match(r'\d+.\d+.\d+(\.\d+)?(-(rc|pre)\d+)?(-(\w+?)(\d+))?',
                 ver).group(6))
    except: return None

def fork(ver):
    try: return re.match(r'\d+.\d+.\d+(\.\d+)?(-(rc|pre)\d+)?(-(\w+))?', ver).group(4)
    except: return None

def get_ver(makefile):
    """ Read the version information from the specified makefile """
    part = {}
    parts = "VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION".split(' ')
    m = open(makefile)
    for l in m.readlines():
        for p in parts:
            try: part[p] = re.match(r'%s\s*=\s*(\S+)' % p, l).group(1)
            except: pass

    version = "%s.%s.%s" % tuple([part[p] for p in parts[:3]])
    x = part.get("EXTRAVERSION", "")

    if x != "" and x[0] != '-' and x[0] != '.': 
        version += '-'; """hack for ac tree"""
    version += x 
    return version

def compare_ver(a, b):
    """
    Compare kernel versions a and b

    Note that -pre and -rc versions sort before the version they modify,
    -pre sorts before -rc, and -bk, -mm, etc. sort alphabetically.
    """
    if a == b: return 0
    
    c = cmp(float(tree(a)), float(tree(b)))
    if c: return c
    c = cmp(rev(a), rev(b))
    if c: return c
    c = cmp(post(a), post(b))
    if c: return c
    c = cmp(pretype(a), pretype(b)) # pre sorts before rc
    if c: return c
    c = cmp(prenum(a), prenum(b))
    if c: return c
    c = cmp(forkname(a), forkname(b))
    if c: return c
    return cmp(forknum(a), forknum(b))

def last(url):
    for l in urllib.urlopen(url).readlines():
        m=re.search('(?i)<a href="(.*/)">', l)
        if m: n = m.group(1)
    return n

def latest_mm(url, pat):
    url = kernel_url + '/people/akpm/patches/2.6/'
    url += last(url)
    part = last(url)
    return part[:-1]

def latest_ac(url, pat):
    url = kernel_url + '/people/alan/linux-2.6/'
    url += last(url)
    for l in urllib.urlopen(url).readlines():
        m=re.search('(?i)<a href="patch-(.*)\.bz2">', l)
        if m: n = m.group(1)
    return n

def latest_26(url, pat):
    for l in urllib.urlopen(url).readlines():
        m = re.search('"LATEST-IS-(.*)"', l)
        if m: p = m.group(1)
    return p

def latest_dir(url, pat):
    """Find the latest link matching pat at url after sorting"""
    p = []
    for l in urllib.urlopen(url).readlines():
        m = re.search('"%s"' % pat, l)
        if m: p.append(m.group(1))

    if not p: return None

    p.sort(compare_ver)
    return p[-1]

# mbligh is lazy and has a bunch of empty directories
def latest_mjb(url, pat):
    url = kernel_url + '/people/mbligh/'

    # find the last Linus release and search backwards
    l = [ find_ver('2.6'), find_ver("2.6-pre") ]
    l.sort(compare_ver)
    linus = l[-1]

    p = []
    for l in urllib.urlopen(url).readlines():
        m = re.search('"(2\.6\..*/)"', l)
        if m:
            v = m.group(1)
            if compare_ver(v, linus) <= 0:
                p.append(v)

    p.sort(compare_ver)
    p.reverse()

    for ver in p:
        mjb = latest_dir(url + ver, pat)
        if mjb: return mjb

    return None

def latest_26_tip(url, pat):
    l = [ find_ver('2.6'), find_ver('2.6-bk'), find_ver('2.6-pre') ]
    l.sort(compare_ver)
    return l[-1]

# latest lookup function, canonical url, pattern for lookup function,
#  signature flag, description
version_info = {
    '2.4': (latest_dir,
            kernel_url + "/v2.4" + "/patch-%(base)s.bz2",
            r'patch-(.*?).bz2',
            1, "old stable kernel series"),
    '2.4-pre': (latest_dir,
                kernel_url + "/v2.4" + "/testing/patch-%(prebase)s.bz2",
                r'patch-(.*?).bz2',
                1, "old stable kernel series prereleases"),
    '2.6': (latest_26,
            kernel_url + "/v2.6" + "/patch-%(prebase)s.bz2", "",
            1, "current stable kernel series"),
    '2.6-rel': (latest_26,
            kernel_url + "/v2.6" + "/patch-%(prebase)s.bz2", "",
            1, "current stable kernel series RELease"),
    '2.6-rc': (latest_dir,
                kernel_url + "/v2.6" + "/testing/patch-%(prebase)s.bz2",
                r'patch-(.*?).bz2',
                1, "current stable kernel series prereleases"),
    '2.6-pre': (latest_dir,
                kernel_url + "/v2.6" + "/testing/patch-%(prebase)s.bz2",
                r'patch-(.*?).bz2',
                1, "current stable kernel series prereleases"),
    '2.6-bk': (latest_dir,
               kernel_url + "/v2.6" +
               "/snapshots/patch-%(full)s.bz2", r'patch-(.*?).bz2',
               1, "current stable kernel series snapshots"),
    '2.6-git': (latest_dir,
               "http://l4x.org/kernelgit/" +
               "patch-%(full)s.bz2", r'patch-(.*?).bz2',
               1, "test git snapshots"),
    '2.6-tip': (latest_26_tip, "", "", 1,
                "current stable kernel series tip"),
    '2.6-mm': (latest_mm,
               kernel_url + "/people/akpm/patches/" +
               "%(tree)s/%(prebase)s/%(full)s/%(full)s.bz2", "",
               1, "Andrew Morton's -mm development tree"),
    '2.6-ac': (latest_ac,
               kernel_url + "/people/alan/linux-%(tree)s/" +
               "%(prebase)s/patch-%(full)s.bz2", "",
               1, "Alan Cox's -ac development tree"),
    '2.6-tiny': (latest_dir,
                 "http://www.selenic.com/tiny/%(full)s.patch.bz2",
                 r'(2.6.*?).patch.bz2',
                 1, "Matt Mackall's -tiny tree for small systems"),
    '2.6-mjb': (latest_mjb,
                 kernel_url + "/people/mbligh/%(prebase)s/patch-%(full)s.bz2",
                 r'patch-(2.6.*?).bz2',
                 1, "Martin Bligh's random collection 'o crap")
    }

def version_url(ver, sign = 0):
    """ Return the URL for the patch associated with the specified version """
    b = "%.1f" % tree(ver)
    f = forkname(ver)
    p = pre(ver)

    s = b
    if f: s = "%s-%s" % (b, f)
    elif p: s = "%s-pre" % b

    if sign and options["no-gpg"]: return None
    if sign and not version_info[s][3]: return None
    
    v = {
        'full': ver,
        'tree': tree(ver),
        'base': base(ver),
        'prebase': prebase(ver)
        }

    u = version_info[s][1] % v

    if sign: u += ".sign"
    return u

def patch_path(ver):
    return os.path.join(archive, os.path.basename(version_url(ver)))

def download(url, file):
    qprint("Downloading %s" % os.path.basename(url))
    if options["dry-run"]: return 1

    if not options["wget"]:
        p = urllib.urlopen(url).read()
        if p.find("<title>404") != -1: return None
        open(file, 'w').write(p)
    else:
        e = os.system("%s -c -O %s %s" % (options["wget"],
                                          file+".partial", url))
        if e: return None
        os.rename(file+".partial", file)

    return 1

def trydownload(url, file):
    if download(url, file): return file

    # the jgarzik memorial hack
    url2 = re.sub("/snapshots/", "/snapshots/old/", url)
    if url2 != url:
        if download(url2, file): return file
        if url2[-4:] == ".bz2":
            f2 = file[:-4] + ".gz"
            url2 = url2[:-4] + ".gz"
            if download(url2, f2): return f2

    if url[-4:] == ".bz2":
        f2 = file[:-4] + ".gz"
        url2 = url[:-4] + ".gz"
        if download(url2, f2): return f2
        
    return None

def verify(signurl, file):
    if options["gpg-path"] and signurl and not options["dry-run"]:
        sf = file + ".sign"
        sf = trydownload(signurl, sf)
        if not sf:
            error("signature download failed")
            error("removing files...")
            os.unlink(file)
            return 0
            
        qprint("Verifying signature...")
        r = os.system("%s --verify %s %s" % (options["gpg-path"], sf, file))
        if r:
            error("gpg returned %d" % r)
            error("removing files...")
            os.unlink(file)
            os.unlink(sf)
            return 0
    return 1

def get_patch(ver):
    """Return the path to patch for given ver, downloading if necessary"""
    f = patch_path(ver)
    if os.path.exists(f): return f
    if f[-4:] == ".bz2":
        f2 = f[:-4] + ".gz"
        if os.path.exists(f2): return f2

    url = version_url(ver)
    f = trydownload(url, f)
    if not f:
        error("patch download failed")
        sys.exit(-1)

    if not verify(version_url(ver, 1), f):
        sys.exit(-1)

    return f

def apply_patch(ver, reverse = 0):
    """Find the patch to upgrade from the predecessor of ver to ver and
    apply or reverse it."""
    p = get_patch(ver)

    r = ""
    if reverse: r = "-R"

    qprint("Applying %s %s" % (os.path.basename(p), r))
    if options["dry-run"]: return ver

    if p[-4:] == ".bz2":
        err = os.system("bzcat %s | patch -l -p1 %s > .patchdiag" % (p, r))
    elif p[-3:] == ".gz":
        err = os.system("zcat %s | patch -l -p1 %s > .patchdiag" % (p, r))
    else: err = os.system("patch -l -p1 %s < %s > .patchdiag" % (r, p))

    if err:
        sys.stderr.write(open(".patchdiag").read())
        error("patch %s failed: %d" % (p, err))
        sys.exit(-1)
    os.unlink(".patchdiag")

def install_nearest(ver):
    t = tree(ver)
    tarballs = glob.glob(archive + "/linux-%s.*.tar.bz2" % t)
    list = []

    for f in tarballs:
        m = re.match(r'.*/linux-(.*).tar.bz2$', f)
        v = m.group(1)
        d = abs(rev(v) - rev(ver))
        list.append((d, f, v))
    list.sort()

    if not list or (options["full-tarball"] and list[0][0]):
        file = "linux-%s.tar.bz2" % ver
        url = "%s/v%s/%s" % (kernel_url, t, file)
        file = archive + "/" + file

        file = trydownload(url, file)
        if not file:
            error("Tarball download failed")
            sys.exit(-1)
        if not verify(url + ".sign", file):
            sys.exit(-1)
    else:
        file = list[0][1]
        ver = list[0][2]

    qprint("Unpacking %s" % os.path.basename(file))
    if options["dry-run"]: return ver

    err = os.system("tar xjf %s" % file)
    if err:
        error("Unpacking failed: ", err)
        sys.exit(-1)

    err = os.system("mv linux*/* . ; rmdir linux*")
    if err:
        error("Unpacking failed: ", err)
        sys.exit(-1)

    return ver

def find_ver(ver):
    if ver in version_info.keys():
        v = version_info[ver]
        for n in range(5):
            return v[0](os.path.dirname(v[1]), v[2])
            error('retrying version lookup for %s' % ver)
    else:
        return ver

def transform(a, b):
    if a == b:
#        qprint("Nothing to do!")
        return
    qprint("%s -> %s" % (a, b))
    if not a:
        a = install_nearest(base(b))
    t = tree(a)
    if t != tree(b):
        error("Can't patch %s to %s" % (tree(a), tree(b)))
        sys.exit(-1)
    if fork(a):
        apply_patch(a, 1)
        a = prebase(a)
    if prebase(a) != prebase(b):
        if pre(a):
            apply_patch(a, 1)
            a = base(a)

        if post(a) and post(a) != post(b):
            apply_patch(prebase(a), 1)
	    
        ra, rb = rev(a), rev(b)
        if ra > rb:
            for r in range(ra, rb, -1):
                apply_patch("%s.%s" % (t, r), -1)
        if ra < rb:
            for r in range(ra + 1, rb + 1):
                apply_patch("%s.%s" % (t, r))
        a = revbase(b)

        if post(b) and post(a) != post(b):
            apply_patch(prebase(b), 0)
            a = base(b)

        if pre(b):
            apply_patch(prebase(b))
            a = prebase(b)

    if fork(b):
        a = apply_patch(b)

def rename_dir(v):
    """Rename the current directory to linux-v, where v is the function arg"""
    cwd = os.getcwd()
    basedir = os.path.dirname(cwd)
    newdir = os.path.join(basedir, "linux-" + v)
    if os.access(newdir, os.F_OK):
        error("Cannot rename directory, destination exists: %s", newdir);
        return
    os.rename(cwd, newdir)


# Process args

os.chdir(options["directory"])

if options["list-trees"]:
    l = version_info.keys()
    l.sort()
    for tree in l:
        qprint(tree, ["(unsigned)","(signed)"][version_info[tree][3]])
        qprint(" " + version_info[tree][4])

elif options["show-makefile"] and len(args) < 2:
    if not args:
        qprint(get_ver("Makefile"))
    else:
        qprint(get_ver(args[0]))

elif len(args) != 1:
    error("incorrect number of arguments")
    sys.exit(-1)

elif options["show-latest"]:
    qprint(find_ver(args[0]))

elif options["show-url"]:
    qprint(version_url(find_ver(args[0])))

elif options["show-previous"]:
    v = find_ver(args[0])
    p = prebase(v)
    if p == v: p = base(v)
    if p == v:
        if rev(v) > 0: p = "%.1f.%s" % (tree(v), rev(v) -1)
        else: p = "unknown"
    qprint(p)

else:
    if not os.path.exists(options["archive"]):
        qprint("Creating cache directory", options["archive"])
        os.mkdir(options["archive"])

    try: a = get_ver('Makefile')
    except: a = None
    b = find_ver(args[0])
#    qprint("%s -> %s" % (a, b))
    transform(a, b)
    if options["rename-directory"] and not options["dry-run"]:
        rename_dir(b)

    

--------------040006070901080706010700
Content-Type: application/x-shellscript;
 name="snapshot.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="snapshot.sh"

IyEvYmluL3NoCgojIHNjcmlwdCBwcm9kdWNlcyBwYXRjaCogaW4gJFdPUktESVIgYW5kICRD
UHMgb3V0cHV0CiMgdG8gJE9VVAoKIyBhYnNvbHV0ZSBkaXJzCldPUktESVI9JFBXRC93b3Jr
CkdJVFRSRUU9JFBXRC9naXQKIyB3aGVyZSB0byBjb3B5IHBhdGNoKiBhZnRlcndhcmQKT1VU
PX4vd2ViL2tlcm5lbGdpdC8KQ1A9c2NwCiMga2V0Y2h1cCBjb21tYW5kCktFVENIVVA9Imtl
dGNodXAgLUciCiMgZG8gYSBnaXQgcHVsbCBvbiB0aGUgZGlyIGZpcnN0PwpET1BVTEw9MAoK
IyBzY3JpcHQgc3RhcnRzIGhlcmUKCiMgc2F2ZSBjdXJyZW50IHB3ZApFWFBXRD0kUFdECgpl
Y2hvIFdvcmtkaXI6ICAkV09SS0RJUgplY2hvIEdpdCBUcmVlOiAkR0lUVFJFRQoKaWYgWyAh
IC1kICIkV09SS0RJUi9zbmFwc2hvdGJhc2UiIF07IHRoZW4JCglta2RpciAtcCAiJFdPUktE
SVIvc25hcHNob3RiYXNlIgpmaQoKaWYgWyAhIC1kICIkR0lUVFJFRSIgXTsgdGhlbgoJZWNo
byAiQ2Fubm90IGZpbmQga2VybmVsIHRyZWUiCglleGl0IDEKZmkKCmNkICRHSVRUUkVFCgpp
ZiBbICIkRE9QVUxMIiA9PSAiMSIgXTsgdGhlbgoJZ2l0IHB1bGwgb3JpZ2luCmZpCgpIRUFE
PSQoY29tbWl0LWlkKQoKaWYgWyAteiAkSEVBRCBdOyB0aGVuCgllY2hvICJDYW5ub3QgZmlu
ZCBjb21taXQtaWQiCgljZCAkRVhQV0QKCWV4aXQgMwpmaQoKZWNobyBIZWFkOiAkSEVBRApp
ZiBbIC1lICRXT1JLRElSL2hlYWQtJEhFQUQgXTsgdGhlbgoJZWNobyAiU25hcHNob3QgYWxy
ZWFkeSBleGlzdHMiCgljZCAkRVhQV0QKCWV4aXQgMgpmaQoKcm0gLXJmICIkV09SS0RJUi9z
bmFwc2hvdC8iCmNoZWNrb3V0LWNhY2hlIC0tcHJlZml4PSIkV09SS0RJUi9zbmFwc2hvdC8i
IC1hCgpjZCAiJFdPUktESVIvc25hcHNob3RiYXNlIgpCQVNFVkVSPSQoJEtFVENIVVAgLW0g
IiRXT1JLRElSL3NuYXBzaG90L01ha2VmaWxlIikKJEtFVENIVVAgIiRCQVNFVkVSIgppZiBb
ICIkKCRLRVRDSFVQIC1tKSIgIT0gJEJBU0VWRVIgXTsgdGhlbgoJZWNobyAiS2V0Y2h1cCB0
byAkQkFTRVZFUiBmYWlsZWQiCgljZCAkRVhQV0QKCWV4aXQgNQpmaQoKY2QgIiRXT1JLRElS
L3NuYXBzaG90IgojIGdldCBjdXJyZW50IE4KCkNPVU5UPSIkV09SS0RJUi9jb3VudC0kQkFT
RVZFUiIKCmlmIFsgISAtZSAiJENPVU5UIiBdOyB0aGVuCgkjIG5ldyBiYXNldmVyc2lvbgoJ
cm0gJFdPUktESVIvY291bnQtKiAyPi9kZXYvbnVsbAoJTj0xCmVsc2UKCU49JChjYXQgJENP
VU5UIDI+L2Rldi9udWxsKQoJTj0kKCggTiArIDEpKQpmaQoKbXYgTWFrZWZpbGUgTWFrZWZp
bGUudG1wCnNlZCAtZSAicy9eRVhUUkFWRVJTSU9OID1cKC4qXCkvRVhUUkFWRVJTSU9OID1c
MS1naXQkTi8iIE1ha2VmaWxlLnRtcCA+IE1ha2VmaWxlCnJtIE1ha2VmaWxlLnRtcAplY2hv
ICRIRUFEID4gZ2l0LWNvbW1pdC1pZAoKUEFUQ0hGSUxFPSRXT1JLRElSL3BhdGNoLSRCQVNF
VkVSLWdpdCROCmNkICRXT1JLRElSCmxuIC1zICIkUEFUQ0hGSUxFIiBoZWFkLSRIRUFECmRp
ZmYgLXVyTiBzbmFwc2hvdGJhc2Ugc25hcHNob3QgPiAiJFBBVENIRklMRSIKCmlmIFsgIiQo
d2MgLWwgJFBBVENIRklMRSkiID09ICIzIiBdOyB0aGVuCgllY2hvIG9ubHkgY29tbWl0LWlk
IGRpZmZlcnMsIG5vIHBhdGNoZXMgaGF2ZSBiZWVuIGFwcGxpZWQgdG8gdGhlIGJhc2UgdmVy
c2lvbgoJcm0gIiRQQVRDSEZJTEUiCgljZCAkRVhQV0QKCWV4aXQgNApmaQoKZWNobyAkTiA+
ICRDT1VOVApiemlwMiAtOSAtYyAiJFBBVENIRklMRSIgPiAiJFBBVENIRklMRS5iejIiCmd6
aXAgLTkgLWMgIiRQQVRDSEZJTEUiID4gIiRQQVRDSEZJTEUuZ3oiCmNkICRFWFBXRAoKJENQ
ICRQQVRDSEZJTEUqICRPVVQvCgplY2hvICJQcm9kdWNlZCAkKGJhc2VuYW1lICRQQVRDSEZJ
TEUpIgo=
--------------040006070901080706010700--
