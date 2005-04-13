Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVDMNcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVDMNcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 09:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVDMNcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 09:32:52 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:49006 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261348AbVDMN31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 09:29:27 -0400
From: Eli <eli.carter@sbcglobal.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [SCM saga] An alternative to git
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Date: Wed, 13 Apr 2005 08:29:13 -0500
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p6RXCsdnsdhwdQP"
Message-Id: <200504130829.13322.eli.carter@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_p6RXCsdnsdhwdQP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[I sent this from my gmail account last night, but it did not appear to make 
it to the list, so I'm re-sending.  Sorry if you get this twice.]

Linus,

Background:
-----------
The SCM problem is something I've been toying with for a while now on my own 
because I wanted a distributed SCM tool, but didn't like one thing or another 
about the existing projects.  I thought monotone came very close to what I 
wanted, but I didn't like the repository as a binary blob.  So I've been 
playing with my own prototype SCM project.  I'd like to know what you think 
of this approach, and maybe observations on this prototype implementation.

The Repository:
---------------
The on-disk format looks like this:
linux-repository

linux_kernel_repo/
|-- cache
|-- nodes ("revisions" would be a better name)
|-- patches
`-- tags

Files are created in the repository, and never modified once they are there.  
Files are never deleted from the repository (with the possible exception of 
stuff in the cache directory).

The patches directory contains <hashofself>.patch files, which are basically
[comments]
[diffstat]
[diff -aurN]

The nodes directory contains <hashofself>.node files, which have
[author] [date]
[<hash>.node <hash>.patch]
... (There can be 0 or more [node,patch] tuples.)

The tags directory contains files named like this:
1113315703.63-eli@pegasus-linux-2.6.4.tag
(i.e: <epoch time>-<author>-<tag-name>.tag)
that contain the name of a node: <hash>.node

Then finally, there is the cache directory.  With my current implementation, 
this area is used to cache unpacked revisions of the source tree for diffing 
and the like.  The contents of these directories are hard-linked to conserve 
some space.

Repository Implications:
------------------------
This repository layout allows for a number of neat features.
Like git, you can use rsync to push and pull everything from one repository to 
another.  (You'll probably want to exclude (most of) the cache directory.)
But even better than that, you can pull a cached node from a repository into a 
new repository, (such as linux-2.6.11) then pull your current head revision 
and patches tracking back to that node, giving you a minimal repository with 
just the history you want.  Then when you're happy with what you have, push 
it out.
That would let you have every revision of Linux known to man in a public 
repository somewhere (kernel.org?), but you could keep a much reduced copy of 
the repository on your working machine.
And we can do all of that without writing a dedicated SCM server: ftp, sftp, 
rsync, etc. should all work.

Since the patches don't reference a node in themselves, they can be applied to 
nodes other than the one they were created from.  I believe this will allow 
merging to work better than git would allow because we can track that the 
same patch was applied to both of two lines of development that we're trying 
to merge.

Current performance isn't very good, but I haven't really optimized it yet, 
either.  The numbers below are from commits to my repository on a 2.6GHz 
Celeron w/768MB RAM.

Commit 2.6.0	95.31user 354.33system 9:07.91elapsed 82%CPU
Commit 2.6.1	61.53user 139.10system 6:01.20elapsed 55%CPU
Commit 2.6.2	21.48user 32.11system 1:02.36elapsed 85%CPU
Commit 2.6.3	22.40user 31.51system 1:00.45elapsed 89%CPU
Commit 2.6.4	26.41user 42.79system 1:17.18elapsed 89%CPU
Commit 2.6.5	24.16user 38.97system 1:13.21elapsed 86%CPU
Commit 2.6.6	25.37user 38.99system 1:15.28elapsed 85%CPU
Commit 2.6.7	35.83user 55.06system 1:46.76elapsed 85%CPU
Commit 2.6.8	43.94user 70.02system 2:27.96elapsed 77%CPU
Commit 2.6.9	43.90user 75.02system 2:42.44elapsed 73%CPU
Commit 2.6.10	52.16user 89.46system 3:03.61elapsed 77%CPU
Commit 2.6.11	54.47user 93.21system 3:25.57elapsed 71%CPU
Commit 2.6.11.1	14.06user 29.82system 1:04.60elapsed 67%CPU
Commit 2.6.11.2	5.42user 12.66system 0:32.30elapsed 56%CPU
Commit 2.6.11.3	1.91user 1.35system 0:06.49elapsed 50%CPU
Commit 2.6.11.4	1.82user 1.41system 0:06.84elapsed 47%CPU
Commit 2.6.11.5	1.91user 1.31system 0:04.26elapsed 75%CPU
Commit 2.6.11.6	1.89user 1.35system 0:06.94elapsed 46%CPU
Commit 2.6.11.7	2.07user 1.50system 0:07.44elapsed 48%CPU

Doing some profiling leads me to believe that there is a lot of room for 
improvement for the nothing -> 2.6.0 and the 2.6.0 -> 2.6.1 commits.  I 
believe the 2.6.x commits can also be improved.
The 2.6.11.x commits tend to be <10 seconds.  Which should be your common 
case.
(Yes, I know git is blazingly fast, but are these numbers reasonable?  How far 
would they need to go to be reasonable?  I think these are comparable to what 
monotone would do, but they've done some optimization recently, so I'm 
probably slower.)

As for disk usage (du -sck) of the above repository:
152     tags
168     nodes
354572  patches
Those three directories contain all the history.
1379704 cache
And that can be re-created from the nodes+patches.
There is no compression going on here, which would be an easy way to improve 
that.  I haven't implemented that yet though.

The Sandbox:
------------
At the top directory of the sandbox, I have a .scm directory containing state 
information such as current revision and repository location.  The rest is 
just source code.  Pretty straight-forward.

Efficiency/Optimizations:
-------------------------
I used some of the ideas from the git discussion in this implementation.
The sandbox keeps some cached information in the .scm; the file stat 
information, and a current hash of each file.  That way it can look at only 
the files it needs to for committing, diffing, etc.
(Sadly, this may not have helped as much as I expected.  I have a version of 
my tool that just does a straight recursive diff on the whole thing, and the 
times are comparable.  That may just point to a really dumb bug on my part 
though.)
I do a lot of os.system()'s and os.popen()'s that could probably be redone.  
Doing a quick grep, it looks like I use: diff, sed, cp, filterdiff, diffstat, 
grep, tail, patch, find, xargs, stat, sort, sha1sum, rsync and $EDITOR.  (In 
my defense, I was aiming for speed of implementation--after all, git is 
progressing quite quickly.)
It might make sense to glue this together with git -- use your "content 
addressable file system" for the cache directory to get the speed, but use 
the the nodes and patches to record the history.

Implementation:
---------------
Attached is scm.py (pronounced "skimpy"), which as the name suggests, is a 
python implementation of the SCM system I've described.  I'm using Python 
2.3.4 on Fedora Core 3, and I haven't tested this on other 
distributions/platforms/etc.  (This is all original code I've done on my own 
time and equipment, and I'm releasing it under the GPL-v2-or-later, with 
absolutely no warranty, and the warning that it may kill your dog, wreck your 
car, etc.)

There are a number of known issues:
The program is a little user-hostile--when it runs into something unexpected, 
it's liable to raise an exception, print a back-trace, and exit.  Hopefully 
it'll give a useful hint in the exception.  It may even leave something 
in /tmp, though if it does, that's a bug I'd like to hear about.
Sometimes you'll get prompted by patch when scm calls out to it when it really 
should be set up to run non-interactively.
I have not dealt with file renames yet, but I expect that to become part of 
the patch "comment" area, much like the diffstat is.  I have not decided how 
to best represent that.
I have not implemented merging yet, but the groundwork is there.  I expect to 
do a breadth-first search for a common ancestor, find the patches in the line 
of development you are merging into your own that you do not already have in 
your own, apply them to your line of development creating nodes along the 
way, then let you deal with the broken parts.  As a first pass anyway.
I haven't directly addressed file permissions or directories yet.  I'm 
expecting those would wind up being handled similarly to file renames in the 
patch files.
If we want to add arbitrary attributes for patches and/or nodes, we could 
create a "attr" directory containing a directory named after the node or 
patch, and in that, a file like <epoch>-<author>-<attribute-name> containing 
the value of that attribute.  For that matter, we could re-do tags that way.

Quick Start:
------------
./scm.py help
./scm.py init <path-to-new-repository>
./scm.py --repo=<repository> checkout mysandbox
cd mysandbox
<copy your source in>
./scm.py diff
./scm.py diffstat
./scm.py commit
And this one is fun:
./scm.py --repo=<repository> graph | dot -Tps repo-history.ps

Main Points:
------------
I believe that this representation of the kernel history is better than git's 
because I believe it will improve our ability to do merges and more closely 
represents what is occurring.
I believe that the repository design will give us many of the same benefits as 
git, and some that git does not give us.
I believe that the implementation can be significantly improved.
The performance scales primarily by the size of the change, rather than the 
size of the code base or the size of the repository.


Ok, so that's scm.py.  Now, let me lock my ego in this nicely padded safe, don 
the asbestos coveralls, and cower behind this nice sturdy boulder....

Alright, pull out the flame throwers and have at it! :)

Eli
-----------------------. "If it ain't broke now,
Eli Carter              \             it will be soon." -- crypto-gram
eli.carter@sbcglobal.net `--------------------------------------------

--Boundary-00=_p6RXCsdnsdhwdQP
Content-Type: application/x-python;
  name="scm.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scm.py"

#!/usr/bin/python
# scm.py - Copyright 2004,2005 Eli Carter
# License: GPL v2 (or later)
""" scm.py (pronounced "skimpy") is a distributed source control system.
	To get started, run "scm.py help"
"""

import os,sys
import time
import socket
from tempfile import mktemp # FIXME: use mkstemp or whatever the secure one is.
import re
import pwd

# Set the default user id to `whoami`@`hostname`.  This may be overridden by a
# commandline option.
userid = "%s@%s" % ( pwd.getpwuid(os.getuid())[0], socket.gethostname())
default_repo_dir = ''

################################################################################
# UTILITY FUNCTIONS
verbose=1
def debug( s ):
	"If verbosity is turned on, display diagnostic information to stderr."
	if verbose >= 2:
		sys.stderr.write( s )
		sys.stderr.write( '\n' )
		sys.stderr.flush()
def warn( s ):
	"If verbosity is normal, display helpful messages to stdout."
	if verbose >= 1:
		sys.stdout.write( s )
		sys.stdout.write( '\n' )
		sys.stdout.flush()

def do_diff_one_file( oldfile, newfile, oldname='', newname='' ):
	"Returns a list of lines containing the patch data"
	# diff does complain to stderr if one of the files is missing...
	data = os.popen( "diff -auN %s %s 2>/dev/null" % (oldfile,newfile) ).readlines()
	if data:
		# Change the name of the file in the diff output if so asked.
		if oldname:
			# The first line is of the form "--- [oldfile]\t....."
			restofline = data[0].split("\t")[1]
			data[0] = "--- %s\t%s" % ( oldname, restofline )
		if newname:
			# The second line is of the form "+++ [newfile]\t....."
			restofline = data[1].split("\t")[1]
			data[1] = "+++ %s\t%s" % ( newname, restofline )
	return data

def edit_files( filenamelist ):
	"edit the specified file(s) using the prefered editor"
	if os.environ.has_key('EDITOR'):
		editor = os.environ[ 'EDITOR' ]
	else:
		editor = 'gvim -f'
	os.system( "%s '%s'" % ( editor, "' '".join( filenamelist ) ))

def do_getcomment( diffstatdata, additionalcomments='' ):
	"Prompts the user for a commit comment given the patch file, diffstat, and any extra comments to include in the template. Returns comment string."
	tmpfile = mktemp()
	open( tmpfile, 'w').write('\n')
	templatefile = os.popen( "sed 's/^/SCM: /' >> %s" % tmpfile, 'w')
	templatefile.write( '\n' )
	templatefile.write( additionalcomments )
	templatefile.write( '\n' )
	templatefile.writelines( diffstatdata )
	templatefile.write( '\n' )
	templatefile.close()
	edit_files( [tmpfile,] )
	# strip "SCM:" lines from tmpfile content, save the rest in comment
	comment = os.popen( "grep -v '^SCM:' %s" % tmpfile, 'r' ).read()
	os.unlink( tmpfile )
	return comment

def do_validate_comment( comment ):
	"""This currently just checks that there was something useful entered.  In
	the future, it would be nice to have it allow a hook for the user to
	provide a validator as well to check that the commit log meets their
	guidelines."""
	wspace = re.compile( "[^ \t\n]", re.M )
	if not wspace.search( comment ):
		comment = ''
	return comment

def prependstr( str, data ):
	"prependstr( str, data ) -> newdata with str prepended to each line of data"
	lines = data.split('\n')
	newdata = []
	for x in lines:
		newdata.append( str + x )
	return '\n'.join( newdata )

def copyfile( src, dest ):
	"copyfile( src, dest ) copies file src to dest"
	# FIXME: This is just a quick-n-dirty way to do this.
	os.system( "cp %s %s" % ( src, dest ) )

################################################################################
# OBJECT CLASSES

class patch:
	"A class for handling patch files."
	def __init__(self, repo, name=None, importfrom=None ):
		"__init__(self, repo, name=None )"
		self.repo = repo
		self.diffstatdata = None
		self.diffdata = None
		self.filelist = None
		self.patchfile = ''
		if name:
			self.load( name )
		elif importfrom:
			self.importfrom( importfrom)
		else:
			self.create()
	def create(self):
		"Creates a new patch"
		# Allocate a new patch number
		self.time = time.asctime()
		self.userid = userid
		self.comment = ''
	def load(self, name):
		"patch.load(name) -> loads a patch from within the repository"
		self.patchfile = self.repo.getpatchfilename( name )
		f = open( self.patchfile, 'r')
		f.readline() # Drop the #!/bin/sh line
		# load the header information
		header = f.readline().split()
		self.userid = header[1]
		self.time = ' '.join( header[2:-1] )
		# We want to delay bringing in the rest of the patch, and it would be
		# ideal to be able to provide a file object that represents a slice of
		# a file on disk so that we don't have to create a copy of each part
		# into another file just for read operations.  It seems so wasteful.
		pass
	def importfrom(self, filename):
		"patch.importfrom(filename) -> uses given file to create a patch file for this repository that is as close as possible to it."
		# This is a bit like .load(), but should be as forgiving as possible,
		# and creates a new patch file in the repository
		# What forms should I explicitly recognize here?
		# email: (TODO) will have a timestamp, and an email address.
		# Just a diff: pull it in for this user at current time.
		# A diff with commentary before it: pull in for this user and
		# automatically set the comment.
		# A patch file copied from another repository.
		# A cvs diff with or without commentary.
		# cvsps output
		#
		# FOR NOW AT LEAST:
		# Just assume this is a diff with or without comments
		self.userid = userid
		self.time = time.asctime()
		# filterdiff strips everything except the diff portion from the file.
		self.diffdata = os.popen( "filterdiff < %s" % filename ).readlines()
		tempfile = mktemp()
		os.popen( "diffstat -p0 > %s" % tempfile, "w" ).writelines( self.diffdata )
		self.diffstatdata = open(tempfile).readlines()
		os.unlink( tempfile )
		
		# Grab the lines that got filtered out as comments
		tempfile = mktemp()
		os.popen( "diff -u %s - | grep -e '^-' | tail +2 | sed 's/^-//' > %s" % (filename, tempfile) ,"w").writelines(self.diffdata)
		self.comment = open(tempfile).read().strip()
		os.unlink( tempfile )
		self.save()
	def save(self):
		"Saves the patch to disk, returns True on success, False on failure"
		temporaryfile = mktemp()

		# Make sure that difffile and diffstatfile are both ready
		self.getfilelist()

		if not self.comment:
			comment = do_getcomment( self.diffstatdata )
			if not self.setcomment( comment ):
				return False
		pfile = open( temporaryfile, 'w' )
		pfile.write( "#!/bin/sh\n" ) # Once file movement functionality is implemented.
		pfile.write( "# %s %s\n#\n" % (self.userid, self.time) )
		pfile.write( prependstr( '# ', self.comment.strip() ) )
		pfile.write( '\n#\n' )
		pfile.write( prependstr( '# ', "".join(self.diffstatdata).rstrip()) )
		pfile.write( '\n#\n' )
		pfile.writelines( self.diffdata )
		pfile.close()

		# Atomically rename the file to the real filename.
		hashval = self.repo.filehash( temporaryfile )
		self.patchfile = self.repo.getpatchfilename( "%s.patch" % hashval )
		os.chmod( temporaryfile, 0555 )
		os.rename( temporaryfile, self.patchfile )
		return True
	def setfilelist( self, filelist ):
		"Sets a list of files that we care about changing"
		self.filelist = filelist
	def getfilelist( self ):
		"Returns the list of files modified by this patch."
		# Read from the file if self.filelist has not been initialized yet.
		if self.filelist == None:
			if self.patchfile:
				# read the filelist from the patch
				self.filelist = []
				lines = self.getloglines()
				lines.reverse()
				for line in lines[2:]: # skip the last # and the summary of changed files
					if line == "\n":
						break
					#  b/somedir/anotherfile |    1 +
					filename = line.split("|")[0][3:].strip()
					self.filelist.append( filename )
				self.filelist.reverse()
				#print self.filelist # DEBUG
			else:
				diffstatdata = self.diffstatdata[:-1]
				self.filelist = map( lambda x: x.split("|")[0].strip()[2:], diffstatdata )
		return self.filelist
	def setdelta( self, delta ):
		"setdelta( delta ) Make this patch object use the given delta as its change."
		self.filelist = delta.keys()
		self.diffdata = []
		for data in delta.values():
			self.diffdata += data
		tempfile = mktemp()
		os.popen( "diffstat -p0 > %s" % tempfile, "w" ).writelines( self.diffdata )
		self.diffstatdata = open( tempfile ).readlines()
		os.unlink( tempfile )
	def setcomment(self, comment):
		"Sets the patch comment, returns True on success, False on failure."
		if do_validate_comment( comment ):
			self.comment = comment
			return True
		else:
			warn( "No valid commit log provided." )
			return False
	def apply( self, dirname=os.curdir, quiet=False ):
		"apply( [dirname] ) - applies this patch to the given directory"
		cwd = os.getcwd()
		os.chdir( dirname )
		if quiet:
			silence = ">/dev/null 2>/dev/null"
		else:
			silence = ""
		# Determine how we should apply the delta.  By doing this, we can use
		# the patch class for temporary patches we don't want to save to the
		# repository.
		if self.patchfile:
			os.system( "patch -p1 -i %s %s" % (self.patchfile, silence) )
		else:
			os.popen( "patch -p1", "w" ).writelines( self.diffdata )
		os.chdir( cwd )
	def revert( self, dirname=os.curdir ): # FIXME: Won't always work.
		"revert( [dirname] ) - reverts this patch in the given directory"
		cwd = os.getcwd()
		os.chdir( dirname )
		os.system( 'patch -p1 -R -i %s' % self.patchfile )
		os.chdir( cwd )
	def getloglines( self ):
		"Return the text and headers of commit log for this patch as a list."
		f = open( self.patchfile, 'r')
		f.readline() # Drop the #!/bin/sh line.
		loginfo = []
		while 1:
			thisline = f.readline()
			if thisline.startswith( "# " ):
				loginfo.append(thisline[2:])
			elif thisline.startswith( "#" ):
				loginfo.append(thisline[1:])
			else:
				break
		return loginfo
	def getlog( self ):
		"Return the text and headers of commit log for this patch as a string."
		return "".join( self.getloglines() )

class hashfile:
	"Hashfile class - provides an easy way to deal with a file containing filename-hash pairs"
	def __init__( self, filename ):
		"hashfile( filename )"
		self.filename = filename
		self.hashes = {}
		if os.path.exists( filename ):
			self.load()
	def load( self ):
		"load() loads file contents into self.hashes"
		hashfile = open(self.filename)
		self.hashes = {}
		while True:
			line = hashfile.readline()
			if not line:
				break
			(filename, thishash) = line.split("\t")
			self.hashes[ filename ] = thishash[:-1] # Strip newline
	def save( self ):
		"save() saves file contents to disk"
		tempfile = mktemp()
		myfile = open(tempfile,'w')
		for filename in self.hashes.keys():
			myfile.write( "%s\t%s\n" % (filename, self.hashes[filename]) )
		os.rename( tempfile, self.filename )
def hashfile_changedfiles( hashfile1, hashfile2 ):
	"hashfile_changedfiles( hashfile1, hashfile2 ) -> list of changed files"
	changedlist = []
	hash1 = hashfile1.hashes.copy()
	for filename in hashfile2.hashes.keys():
		if hash1.has_key( filename ):
			if hash1[filename] != hashfile2.hashes[filename]:
				changedlist.append( filename )
			del hash1[filename]
		else:
			changedlist.append( filename )
	changedlist += hash1.keys()
	return changedlist

class sandbox:
	"""Sandbox class - represents a sandbox the user has checked out.
	
	The sandbox directory structure looks like this:
	$sandbox/                # tree used as a work area.
	$sandbox/.scm/           # scm-related house-keeping area
	$sandbox/.scm/repository # contains path to the repository
	$sandbox/.scm/basenode   # contains nodeid for its reference area
	$sandbox/.scm/filestate  # cached stat information about the sandbox
	$sandbox/.scm/hashes     # hashes of sandbox files as of the last update to filestate.
	"""
	# Change scmsubdir to "SCM" if you want something more like CVS.
	scmsubdir = ".scm"
	def __init__( self, location=None, new=False ): # repo=None ):
		"""First, see if this is a subdirectory of a sandbox.  If it is not,
		create a sandbox based here if we can."""
		if new:
			self.topdir = os.path.abspath( location )
		else:
			self.topdir = self.find_sandbox_root( location )
		self.scmdir = os.path.join( self.topdir, self.scmsubdir )
		self.repo = None
		if not new:
			self.repo = self.getrepository()
	def create( self, repo, basenodename ):
		"Create a new sandbox with the contents of basenode from the given repository; and initialize the .scm subdirectory."
		self.repo = repo
		nodecachedir = repo.cache( basenodename )
		os.system( "cp -R '%s' '%s'" % (nodecachedir,self.topdir) )
		os.makedirs( self.scmdir )
		# Save a pointer to our repository
		open( os.path.join(self.scmdir,'repository'),'w').write( "%s\n" % repo.topdir )
		# And note the node we were initialized to.
		self.setbasenodename( basenodename )
		self.cache_file_state()
		copyfile( "%s.hashes" % nodecachedir, os.path.join(self.scmdir,"hashes") )
	def cache_file_state( self, filename=None ):
		"Save the stat() information for the files in the sandbox"
		if not filename:
			filename = os.path.join( self.topdir, self.scmsubdir, "filestate" )
		tempfile = mktemp()
		currentdir = os.getcwd()
		os.chdir( self.topdir )
		os.system( "find -type f | xargs -- stat --format=\"%%n\t%%i\t%%s\t%%y\t%%z\" | sort > %s" % (tempfile) )
		os.chdir( currentdir )
		os.rename( tempfile, filename )
	def getrepository( self ):
		"Returns a repository object for this sandbox"
		if not self.repo:
			name = os.path.join( self.scmdir, 'repository')
			repopath = open( name, 'r').read()[:-1]
			self.repo = repository( repopath )
		return self.repo
	def basenodename( self ):
		'basenodename() -> name string'
		filename = os.path.join( self.topdir, self.scmsubdir, 'basenode')
		if os.path.exists( filename ):
			name = open( filename,'r').read()[:-1]
		else:
			name = ""
		return name
	def setbasenodename( self, name ):
		"Set the sandbox's base node to the given node name."
		filename = os.path.join( self.topdir, self.scmsubdir, 'basenode')
		open( filename,'w').write( name + '\n' )
	def update( self, nodename ):
		"modify the sandbox and update the base node for the sandbox"
		# Ask the repository to diff basenode to destination node and apply
		# that as a patch.
		delta = self.repo.diff( self.basenodename(), nodename )
		change = patch( self.repo )
		change.setdelta( delta )
		change.apply( self.topdir, quiet=False )
		self.setbasenodename( nodename )
	def apply( self, patchname ):
		"apply( patchname ) - applies the given patch file to the sandbox"
		repo = self.getrepository()
		patch2apply = repo.getpatch( patchname )
		patch2apply.apply( self.topdir )
	def revert( self, patchname ):
		"revert( patchname ) - reverts the given patch file in the sandbox"
		repo = self.getrepository()
		patch2revert = repo.getpatch( patchname )
		patch2revert.revert( self.topdir )
	def up( self, count ):
		"Update to the parent node <count> times."
		repo = self.getrepository()
		fromnode = self.basenodename()
		os.chdir( self.topdir )
		for n in range(count):
			fromnode = repo.getnode( fromnode )
			arcs = fromnode.arcs
			if not len(arcs):
				print 'Warning: could only go up %s times, not %s.' % (n+1, count )
				break
			parent, patch = arcs[0] # assume the first path back for now.
			self.revert( patch )
			fromnode = parent
		self.setbasenodename( parent )
	def commit( self, comment='', filelist=[] ):
		"Commit the changes in this sandbox to the repository"
		parentnodelist = []
		basenodename = self.basenodename()
		if basenodename: # If this is the first commit, there will be no parent.
			parentnodelist.append(basenodename)
		# FIXME: Once merge is implemented, we need to determine all the base nodes.
		self.getrepository().commit( self, parentnodelist, comment, filelist=filelist )
	def history( self, nodename=None ):
		"Display the history of patches leading up to the given nodename"
		if not nodename:
			nodename = self.basenodename()
		self.getrepository().history( nodename )
	def tag( self, tagname ):
		"Create a tag for the current base node."
		r = self.getrepository()
		r.tag( self.basenodename(), tagname )
	def find_sandbox_root( self, basedir='' ):
		"""find_sandbox_root( basedir='' ) -> top level directory of the sandbox
		containing the given directory, or current working directory if not given."""
		if not basedir:
			basedir = os.getcwd()
		d = os.path.abspath( basedir )
		while d != '/' and not os.path.isdir( os.path.join( d, '.scm' )):
			d = os.path.dirname( d )
		if d == '/':
			raise "Given path not in a sandbox."
		return d
	def filestatechanges( self, oldstatefile, newstatefile ):
		"filestatechanges( oldstatefile, newstatefile ) -> list of files that have been touched in some way"
		touched_files = []
		old = open( oldstatefile )
		oldstate = {}
		while True:
			line = old.readline()
			if not line:
				break
			parts = line.split("\t")
			filename = parts[0][2:]
			if not filename.startswith( self.scmsubdir ):
				statinfo = "\t".join(parts[1:])
				oldstate[filename] = statinfo 
		new = open( newstatefile )
		while True:
			line = new.readline()
			if not line:
				break
			parts = line.split("\t")
			filename = parts[0][2:]
			if filename.startswith( self.scmsubdir ):
				continue
			statinfo = "\t".join(parts[1:])
			if oldstate.has_key( filename ):
				if oldstate[filename] != statinfo:
					touched_files.append( filename )
				del oldstate[filename]
			else:
				touched_files.append( filename )
		touched_files += oldstate.keys()
		return touched_files
	def update_hashes( self ):
		"Update the hashes for this sandbox"
		new_file_state = mktemp()
		self.cache_file_state( new_file_state )
		file_state = os.path.join( self.topdir, self.scmsubdir, "filestate" )
		files_to_check = self.filestatechanges( file_state, new_file_state )
		current_hashes = hashfile( os.path.join( self.scmdir, "hashes" ) )
		for filename in files_to_check:
			thishash = self.repo.filehash( filename )
			current_hashes.hashes[ filename ] = thishash
		current_hashes.save()
		os.rename( new_file_state, file_state )
	def diff( self, nodename=None, filelist=[] ):
		"""diff( nodename=None, filelist=[] ) -> list of output lines
		Defaults to the sandbox base node and all files."""
		# need to think about diffing relative to current subdir of the sandbox.
		if not nodename:
			nodename = self.basenodename()
		self.update_hashes()
		myhashes = hashfile( os.path.join( self.scmdir, "hashes") )
		nodecache = self.repo.cache( nodename )
		nodehashes = hashfile( "%s.hashes" % nodecache )
		changed = hashfile_changedfiles( myhashes, nodehashes )
		delta = {}
		currentdir = os.getcwd()
		currentsubdir = currentdir[len(self.topdir):]
		for filename in changed:
			# Make sure it is a file we were asked to diff
			if filelist:
				relative_filename = os.path.join(currentsubdir,filename)
				if relative_filename not in filelist:
					continue
			diffdata = do_diff_one_file( 
				os.path.join( nodecache, filename ),
				os.path.join( self.topdir, filename ),
				os.path.join( "a", filename ),
				os.path.join( "b", filename ) )
			if diffdata:
				delta[filename] = diffdata
		return delta

class node:
	""" A node is a file containing text in the form:
		you@example.net\t<date>
		<hash>.node\t<hash.patch>
		[<hash>.node\t<hash.patch>
		...]
	"""
	def __init__( self, repo, filename=None ):
		"node constructor, takes a filename of an existing node file."
		self.repo = repo
		if type(self.repo) == type(""):
			raise "Internal error: no repository specified creating node"
		self.filename = filename
		# Initialize internal vars...
		if filename:
			self.load( filename )
		else:
			self.arcs = []
			self.author = ""
			self.date = ""
			self.hash = ""
	def load( self, filename ):
		"Reads given filename and initializes author, date, and arcs[]"
		self.file = open( filename, "r" )
		( self.author, self.date ) = self.file.readline().rstrip().split("\t")
		# arcs in form [ [ <hash>.node, <hash>.patch], ... ]
		self.arcs = map( lambda x: x.rstrip().split("\t"), self.file.readlines() )
		self.hash = os.path.basename( filename )
		if self.hash.endswith( ".node" ):
			self.hash = self.hash[:-len(".node")]
		else:
			raise "Bad node filename \"%s\"" % filename
	def save( self ):
		"Writes node to disk"
		temp = mktemp()
		data = [ "%s\t%s\n" % (self.author,self.date) ]
		for arc in self.arcs:
			data.append( "%s\t%s\n" % arc )
		open(temp,"w").write( ''.join(data))
		self.hash = self.repo.filehash( temp )
		self.filename = os.path.join( self.repo.getnodedir(), "%s.node" % self.hash )
		os.rename( temp, self.filename )
	def name( self ):
		"Returns the full node name"
		return os.path.basename( self.filename )

class tag:
	"A tag is a file with a useful name that references a specific node."
	# tags/<epictime>-user@example.net-tagname.tag
	# This has the name of the node file such as:
	# 973d23c2bc770cb0d92aa71ad4922d11d5219323.node
	def __init__( self, repo, filename=None ):
		"Expects an absolute filename"
		self.repo = repo
		self.filename = filename
		if filename:
			self.load(filename)
		else:
				self.author = ""
				self.date = ""
				self.tag = ""
				self.node = ""
	def load( self, filename ):
		"Expects an absolute filename"
		nameparts = os.path.basename(filename).split("-")
		self.date = nameparts[0]
		self.author = nameparts[1]
		name_and_extension = "-".join(nameparts[2:])
		if name_and_extension.endswith( ".tag" ):
			self.tag = name_and_extension[:-len(".tag")]
		else:
			raise "Corrupt tag \"%s\" found" % filename
		self.node = open( filename ).read().rstrip()
	def save( self ):
		"Writes the tag to the repository"
		tempfile = mktemp()
		f = open( tempfile, "w" )
		f.write( "%s\n" % self.node )
		f.close()
		basename = "%s-%s-%s.tag" % (self.date, self.author, self.tag)
		self.filename = os.path.join( self.repo.gettagdir(), basename )
		os.rename( tempfile, self.filename )
	def __str__( self ):
		"Return a string representation of a tag"
		# FIXME: This isn't really unique... but this is backwards compatible
		# with my test suite.
		return "%s:%s = %s" % (self.author, self.tag, self.node)

class repository:
	"""Directories within the repository:
		$repository/               # Contains cset, node, and tag files
		$repository/cache/<nodename>
		$repository/nodes/
		$repository/patches/
		$repository/tags/
	"""
	def __init__( self, location='' ):
		"Constructor for the repository class.  Takes an optional directory name.  (Default of current directory.)"
		self.topdir = os.path.abspath( location )
	def create( self ):
		"Create the directory structure for this repository"
		for d in [ 'cache', 'nodes', 'tags', 'patches' ]:
			os.makedirs( os.path.join(self.topdir, d) )
		self.create_new_node()
	def getnodedir( self ):
		"Return the absolute path of the directory for nodes."
		return os.path.join( self.topdir, 'nodes')
	def gettagdir( self ):
		"Return the absolute path of the directory for tags."
		return os.path.join( self.topdir, 'tags')
	def getpatchdir( self ):
		"Return the absolute path of the directory for patches."
		return os.path.join( self.topdir, 'patches')
	def createsandbox( self, sandlocation, mybasenodename ):
		"Does a checkout from the repository and creates a sandbox using the given nodename/tagname"
		mybasenodename = self.tag2node( mybasenodename )
		s = sandbox( sandlocation, new=True )
		s.create( self, mybasenodename )
		return s
	def create_new_node( self, arcs=[] ):
		"""create_new_node( self, comment='text...', arcs=[ (node,patch),...] )"""
		newnode = node( self )
		newnode.date = time.asctime() # FIXME: Do we want this or epoc time?
		newnode.author = userid
		newnode.arcs = arcs
		newnode.save()
		return newnode
	def allocid( self ):
		"Allocate an id value from the repository"
		numfile = os.path.join( self.topdir, 'number-%s' % userid )
		if os.path.isfile( numfile ):
			value = int( open( numfile, 'r' ).read()[:-1] ) + 1
			nodeid =  "%s:%d" % (userid,value)
		else:
			value = 0
			nodeid = '0'
		open( numfile, 'w').write( '%s\n' % value )
		# print 'allocated %s' % value # DEBUG
		return nodeid
	def cache( self, nodename ):
		"cache( self, nodename ) -> full path to cached revision"
		# See if this node has already been cached.  If it has, great! we just
		# return.  Otherwise, we cache the parent node, then copy and patch to
		# create this node.
		debug( "caching %s" % nodename )
		cachedir = os.path.join(self.topdir, 'cache')
		fullpath = os.path.join(cachedir, nodename )
		if os.path.isdir( fullpath ):
			debug( "node %s is already cached" % nodename )
		else:
			# Get the previous revision
			prevnode = node( self, os.path.join( self.topdir, 'nodes', nodename ) )
			arcs = prevnode.arcs
			if len( arcs ):
				arc = arcs[0] # For now, just take the first one.
				parentnodename = arc[0]
				patchname = arc[1]
				# cache that revision
				self.cache( parentnodename )
				# copy & hardlink
				# Busybox does not support 'cp -l'. Tough.
				cmd = 'cd %s; cp -Rl %s %s' % ( cachedir, parentnodename, nodename )
				debug( 'running "%s"' % cmd )
				os.system( cmd )
				# And apply the patch
				change = patch( self, patchname )
				change.apply( fullpath, quiet=True )

				# Update the hash list for this node
				# Read in the hash list for the parent node, update that list, then write it out again....
				parenthashfilename = os.path.join( cachedir, "%s.hashes" % parentnodename )
				hashtable = hashfile( parenthashfilename )
				for filename in change.getfilelist():
					cachedfile = os.path.join( cachedir, nodename, filename )
					thishash = self.filehash( cachedfile )
					hashtable.hashes[filename] = thishash
				myhashfilename = os.path.join( cachedir, "%s.hashes" % nodename )
				myhashtable = hashfile( myhashfilename )
				myhashtable.hashes = hashtable.hashes
				myhashtable.save()
			else: # This is a/the root node.
				debug( "node %s is a root node" % nodename )
				os.makedirs( fullpath )
				open( "%s.hashes" % fullpath, "w") # Create the .hashes file
		return fullpath
	def commit( self, fromsandbox, parentnodenames, comment='', filelist=[], forcecommit=0 ):
		"""commit( self, fromsandbox, parentnodenames, comment ) -> new_node
		We must allow multiple parent nodes, so this is always an array."""
		arcs=[]
		if len(parentnodenames) > 1:
			forcecommit=1
		for parentnodename in parentnodenames:
			newpatch = patch( self )
			delta = fromsandbox.diff( filelist=filelist )
			newpatch.setdelta( delta )
			# FIXME: This won't make sense once we support merging.
			if (not forcecommit) and (not len(newpatch.getfilelist())):
				# Then no changes were made, so we don't want to commit the files afterall.
				warn( "No changes in repository, so not doing commit." )
				return None
			# If we were given a comment, set that, but abort if it was bad.
			if comment:
				if not newpatch.setcomment( comment ):
					warn( "Bad comment given for patch." )
					return None
			# Write it to disk, but abort if there was a problem.
			if not newpatch.save():
				debug( newpatch.getfilelist() )
				debug( os.getcwd() )
				warn( "ERROR: Failed to save new patch." )
				return None

			patchfile = os.path.basename( newpatch.patchfile )
			arcs.append( (parentnodename, patchfile) ) # Record the graph data

		basenode = self.create_new_node( arcs )
		fromsandbox.setbasenodename( basenode.name() )
		return basenode
	def importpatch( self, basenodename, patchfilename ):
		"""importpatch( basenodename, patchfilename ) -> nodename
		Apply patch to basenode, ask the user for a commit comment, returns None on error."""
		# FIXME: Need to validate the basenodename
		newpatch = patch( self, importfrom = patchfilename )
		patchname = None
		if newpatch.save():
			# Then create a new node using that.
			arc = (basenodename, os.path.basename(newpatch.patchfile))
			newnode = self.create_new_node( [arc,])
			patchname = newnode.name()
		return patchname
	def getnode( self, node_tag_name ):
		"returns the node object for the given node or tag name"
		filename = os.path.join( self.topdir, 'nodes', node_tag_name )
		if not os.path.exists( filename ): # Then maybe this is a tag.
			filename = os.path.join( self.topdir, 'tags', "tag-%s" % node_tag_name)
		if not os.path.exists( filename ):
			raise "Node or tag does not exist"
		return node( self, filename )
	def getpatchfilename( self, patchname ):
		"Given a string that identifies a patch, return the full path of the patch file.  (The file may not exist.)"
		# We need to determine the filename without depending on its existance.
		# The user may specify the hash value, the filename, or the absolute
		# filename for the patch.
		justnumber = re.compile( '^[0-9a-f]+$' )
		fullfilename = re.compile( '^[0-9a-f]+\\.patch$' )
		fullpathname = re.compile( '^.*/[0-9a-f]+\\.patch$' )
		if justnumber.match( patchname ):
			pfile = os.path.join( self.topdir, 'patches', "%s.patch" % (patchname) )
		elif fullfilename.match( patchname ):
			pfile = os.path.join( self.topdir, 'patches', patchname)
		elif fullpathname.match( patchname ):
			pfile = patchname
		else:
			raise "Bad patch ID %s" % patchname
		return pfile
	def getpatchfile( self, patchname ):
		"Returns an open file object for the specified patch."
		pfile = self.getpatchfilename( patchname )
		return open( pfile, 'r')
	def getpatch( self, patchname ):
		"getpatch( patchname ) -> patch object"
		return patch( self, name = patchname )
	def log( self, startnode=None ):
		"Display a log of commits to stdout."
		basedir = self.getpatchdir()
		if startnode:
			# Start with a specified node and follow its history, listing most
			# recent changes first
			if not startnode.endswith( ".node" ):
				startnode += ".node"
			while 1:
				thisnode = self.getnode( startnode )
				if len(thisnode.arcs) == 0:
					break
				patchname = thisnode.arcs[0][1]
				thispatch = patch( self, patchname )
				print "%s.node" % (thisnode.hash)
				print thispatch.getlog()
				startnode = thisnode.arcs[0][0]
		else:
			# Dump all the commit log messages we have.
			# TODO: It would be nice to sort this output somehow.
			filenames = os.listdir( basedir )
			for patchfile in filenames:
				thispatch = patch( self, name=os.path.join( basedir, patchfile ) )
				print thispatch.getlog()
	def graph( self ):
		"Display revision history in a form suitable for graphviz"
		# Q: Do we loop thru all arcs? or all nodes?
		# A: We must do nodes since patches are not 1-to-1 with arcs.
		sys.stdout.write( 'digraph G {\n' )
		sys.stdout.write( '# version tree\n' )
		for thisnode in self.nodelist():
			child = thisnode.name()
			if thisnode.arcs:
				for arc in thisnode.arcs:
					parent = arc[0]
					change = arc[1]
					sys.stdout.write( '"%s" -> "%s" [label="%s"]\n' % ( parent, child, change ) )
			else:
				sys.stdout.write( '"%s"\n' % (child) )
		# Display all the tags
		# Each line must have all the tags for a given node, so we have to
		# collect them all and group them.
		sys.stdout.write( '# tags\n' )
		tagsbynode = {}
		for thistag in self.taglist():
			thistagname = ":".join( [thistag.author, thistag.tag] )
			if tagsbynode.has_key( thistag.node ):
				tagsbynode[thistag.node].append(thistagname)
			else:
				tagsbynode[thistag.node] = [ thistagname ]
		for thisnode in tagsbynode.keys():
			sys.stdout.write( '"%s" [label="%s\\n\'%s\'"]\n' % (thisnode, thisnode, "'\\n'".join( tagsbynode[thisnode] ) ) )
		sys.stdout.write( '}\n' )
		sys.stdout.flush()
	def nodelist( self ):
		"nodelist() -> list of node objects for all nodes in the repository"
		nodedir = self.getnodedir()
		nodenames = os.listdir( nodedir )
		nodes = map( lambda x: node( self, os.path.join(nodedir,x)), nodenames )
		return nodes
	def get_history( self, nodename ):
		"get_history(nodename) -> list of arcs leading up to this node"
		thisnode = self.getnode( nodename )
		arcs = thisnode.arcs
		if len( arcs ):
			arc = arcs[0]
			parentnode = arc[0]
			history = self.get_history( parentnode )
			history.append( arc )
		else: # this is a root node
			history = [ (nodename,None),]
		return history
	def tag( self, nodename, tagname ):
		"tag( self, nodename, tagname ) create a tag"
		if tagname.endswith( ".node" ):
			raise "Invalid tag name.  It looks like a node name."
		newtag = tag( self )
		newtag.author = userid
		newtag.tag = tagname
		newtag.node = nodename
		newtag.date = time.time()
		newtag.save()
	def taglist( self ):
		"taglist() -> list of tag objects for all tags in the repository"
		tagdir = self.gettagdir()
		tagnames = os.listdir( tagdir )
		tags = map( lambda x: tag( self, os.path.join(tagdir,x)), tagnames )
		return tags
	def findtag( self, tagstring=None, author=None, date=None ):
		"Return a tag object matching the constraints given"
		# There is a LOT of room for speedups here...
		# FIXME: This assumes (for now) that there is only one match...
		tags = self.taglist()
		for tag in tags:
			if tagstring == tag.tag:
				return tag
		return None
	def tag2node( self, tagname ):
		"tag2node( self, tagname ) -> nodename"
		# First, see if there is a node by this name
		try:
			thisnode = self.getnode( tagname )
		except:
			thisnode = None
		if thisnode:
			return thisnode.name()
		tag = self.findtag( tagname )
		if not tag:
			# Whoops! There isn't one!
			raise "Could not find a tag to match \"%s\"." % tagname
		return tag.node
	def tags( self ):
		"tags( self ) -> list of tag names"
		return map( lambda x: x.tag, self.taglist())
	def filehash( self, filename ):
		"Returns the hash of the file contents"
		if not os.path.exists( filename ):
			filename = "/dev/null"
		return os.popen( "sha1sum %s" % filename ).read().split()[0]
	def diff( self, node1, node2 ):
		"Return the delta between the specified nodes."
		node1cache = self.cache( node1 )
		node1hashfile = hashfile( "%s.hashes" % node1cache )
		node2cache = self.cache( node2 )
		node2hashfile = hashfile( "%s.hashes" % node2cache )
		changed_files = hashfile_changedfiles( node1hashfile, node2hashfile )
		delta = {}
		for filename in changed_files:
			diffdata = do_diff_one_file( 
				os.path.join( node1cache, filename ),
				os.path.join( node2cache, filename ),
				os.path.join( "a", filename ),
				os.path.join( "b", filename ) )
			if diffdata:
				delta[filename] = diffdata
		return delta

################################################################################
# USER COMMANDS
commands={}

def printhelp( args=None ):
	"Display this help message"
	print "To create a new repository, use 'scm init <repopath>'"
	print "To create a new sandbox, use 'scm checkout <repo> <sandbox> [node]'"
	print "Also the usual commands of commit, add, mv, cp, rm, apply, diff, log, tag"
	print "Additional commands are update, mergecset, graph"
	print ""
	cmdlist = commands.items()
	cmdlist.sort()
	for cmd in cmdlist:
		print wordwrap( "%s - %s" % (cmd[0], cmd[1].__doc__) )
commands['help'] = printhelp
def wordwrap( text, width = 80, indent=8 ):
	"Wrap text at column width.  Indent subsequent lines by 'indent' spaces."
	wrapped = []
	words = text.split(' ')
	firstword = 0
	currentword = 1
	currentindent = 0
	while currentword < len(words):
		while True:
			thisline = ' '.join(words[firstword:currentword])
			if len( thisline ) >= width - currentindent or currentword > len(words):
				break
			currentword += 1
		wrapped.append( " "*currentindent + ' '.join(words[firstword:currentword-1]) )
		currentindent = 8
		firstword = currentword
	return '\n'.join( wrapped )

def scm_initrepo( args ):
	"init <repository directory> - creates a repository using the specified directory."
	if len(args) >= 3:
		repodir = args[2]
	elif default_repo_dir:
		repodir = default_repo_dir
	else:
		sys.stderr.write( "Error: No repository specified.\n" )
		printhelp()
		sys.exit(1)
	repository( repodir ).create() # repository name
commands[ 'init' ] = scm_initrepo

def scm_checkout( args ):
	"checkout <sandbox> <tag|node>"
	if len(args) != 4:
		sys.stderr.write( "Syntax error: wrong number of arguments." )
		printhelp()
		sys.exit(1)
	repodir = default_repo_dir
	sanddir = args[2]
	r = repository( repodir )
	nodetag = args[3]
	r.createsandbox( sanddir, nodetag )
commands[ 'checkout' ] = scm_checkout
commands[ 'co' ] = scm_checkout

def scm_edit( args ):
	"edit the specified file(s) using the prefered editor and commit the changes to the repository."
	edit_files( args[2:] )
	# and commit.
	s = sandbox( )
	s.commit( )
commands['edit'] = scm_edit

def scm_graph( args ):
	"graph [repository] - display a dump of the nodes and patches that exist in the repository."
	if len( args ) > 2: # They specified a repository
		repodir = args[2]
		r = repository(repodir)
	elif default_repo_dir:
		r = repository( default_repo_dir )
	else: # Assume we're inside a sandbox
		s = sandbox( )
		r = s.getrepository()
	r.graph()
commands[ 'graph' ] = scm_graph

def scm_commit( args ):
	"Commit all pending changes (for the specified files) to the repository"
	s = sandbox()
	s.commit( filelist=args[2:])
commands['commit'] = scm_commit

def scm_diff( args ):
	"Display differences between the current sandbox and its base node in the repository. (All files unless filenames are given.)"
	s = sandbox( os.getcwd() )
	delta = s.diff( filelist=args[2:] ) # against base node
	for data in delta.values():
		sys.stdout.writelines( data )
commands['diff'] = scm_diff

def scm_diffstat( args ):
	"Display summary of differences between the current sandbox and its base node in the repository. (All files unless filesnames are given.)"
	s = sandbox( os.getcwd() )
	delta = s.diff( filelist=args[2:] ) # against base node
	diffstat_filter = os.popen( "diffstat -p1", "w")
	for data in delta.values():
		diffstat_filter.writelines( data )
commands['diffstat'] = scm_diffstat

def scm_status( args ):
	"Display some helpful information about the current sandbox and its repository."
	s = sandbox()
	print "Sandbox revision: %s" % s.basenodename()
	r = s.getrepository()
	print "Repository: %s" % r.topdir
commands['status'] = scm_status

def scm_showpatch( args ):
	"showpatch [patch [patch...]]  Displays the contents of the patch(es)."
	s = sandbox()
	r = s.getrepository()
	for patch in args[2:]:
		p = r.getpatchfile( patch )
		sys.stdout.write( p.read() )
commands['showpatch'] = scm_showpatch

def scm_prevup( args ):
	"Updates the sandbox to the base node's parent node."
	s=sandbox()
	if len(args) > 2:
		count = int( args[2] )
	else:
		count = 1
	s.up( count )
commands['prevup'] = scm_prevup

def scm_update( args ):
	"Change the base node to the given node.  Will modify the sandbox in the process."
	tag_or_nodename = args[2]
	s = sandbox()
	r = s.getrepository()
	nodename = r.tag2node( tag_or_nodename )
	s.update( nodename )
commands['update'] = scm_update

def scm_tag( args ):
	"tag <tagname> [nodename]	Creates a tag."
	tagname = args[2]
	s = sandbox()
	if len(args) > 3:
		nodename = args[3]
		r = s.getrepository()
		r.tag( nodename, tagname )
	else:
		s.tag( tagname )
commands['tag'] = scm_tag

def scm_showtags( args ):
	"Lists all tags in the repository."
	s = sandbox()
	r = s.getrepository()
	for t in r.taglist():
		print t
commands['showtags'] = scm_showtags

def scm_importpatch( args ):
	"importpatch <filename> Creates a new node in the repository based on the current basenode and the given patch file."
	patchfilename = args[2]
	s = sandbox()
	repo = s.getrepository()
	basenode = s.basenodename()
	nodename = repo.importpatch( basenode, patchfilename )
	sys.stdout.write( "%s\n" % nodename )
commands['importpatch'] = scm_importpatch

def scm_log( args ):
	"log [--start=...] lists the checkin comments"
	if len(args) > 2 and args[2].startswith("--start="):
		arg = args[2]
		startnode = arg[len("--start="):]
	else:
		startnode = None
	if default_repo_dir:
		r = repository( default_repo_dir )
	else: # Assume we're inside a sandbox
		s = sandbox( )
		r = s.getrepository()
	r.log( startnode=startnode )
commands['log'] = scm_log

def scm_pushall( args ):
	"scm --repo=repository pushall user@host:/path/to/remoterepo"
	# We want to copy any files we have that they don't, but we don't want to
	# change or overwrite any files.
	local = os.path.join(default_repo_dir, ".")
	remote = args[2]
	ret = os.system( "rsync -r --ignore-existing '%s' '%s'" % (local,remote) )
	sys.exit( ret >> 8 )
commands['pushall'] = scm_pushall

def scm_pullall( args ):
	"scm --repo=repository pullall user@host:/path/to/remoterepo"
	# We want to copy any files we have that they don't, but we don't want to
	# change or overwrite any files.
	local = os.path.join(default_repo_dir, ".")
	remote = args[2]
	ret = os.system( "rsync -r --ignore-existing '%s/' '%s/'" % (remote,local) )
	sys.exit( ret >> 8 )
commands['pullall'] = scm_pullall

def do_scm( argv ):
	"Given arguments, call the appropriate scm method."
	# Check for actions that do not require a sandbox first.
	if len( argv) < 2:
		printhelp( None )
		sys.exit(1)
	# Check for global options
	while argv[1][0] == '-':
		if argv[1] == '-v':
			# We have to specify that we want to make the assignment to the
			# global variable rather than create a new one in this scope.
			global verbose
			verbose = 2
		elif argv[1].startswith( '--userid=' ): # Override the user id value.
			global userid
			userid = argv[1].split( '=' )[1]
		elif argv[1].startswith( "--repo=" ): # Set the repository to act on.
			global default_repo_dir
			default_repo_dir = argv[1].split( '=' )[1]
		else:
			sys.stderr.write( "Unrecognized global option \"%s\"\n" % argv[1] )
			printhelp( None )
			sys.exit(1)
		argv = argv[1:]	
	# Parse the command
	cmd = argv[1]
	if commands.has_key(cmd):
		commands[cmd]( argv )
	else:
		sys.stderr.write( "Unrecognized command \"%s\"\n" % cmd )
		printhelp( None )
		sys.exit(1)

if __name__ == '__main__':
	do_scm( sys.argv )

# vim:ts=4
# vim:shiftwidth=4
# vim:foldmethod=indent
# vim:foldcolumn=6

--Boundary-00=_p6RXCsdnsdhwdQP--

