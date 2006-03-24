Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423150AbWCXF4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423150AbWCXF4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423154AbWCXF4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:56:39 -0500
Received: from mail.suse.de ([195.135.220.2]:39145 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423153AbWCXF4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:56:38 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 24 Mar 2006 16:54:30 +1100
Message-Id: <1060324055430.2345@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 2] knfsd: Update rpc-cache.txt to match recent changes
References: <20060324165210.2285.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./Documentation/rpc-cache.txt |  123 ++++++++++++++++++++++++++----------------
 1 file changed, 77 insertions(+), 46 deletions(-)

diff ./Documentation/rpc-cache.txt~current~ ./Documentation/rpc-cache.txt
--- ./Documentation/rpc-cache.txt~current~	2006-03-24 12:06:14.000000000 +1100
+++ ./Documentation/rpc-cache.txt	2006-03-24 12:15:26.000000000 +1100
@@ -1,4 +1,4 @@
-This document gives a brief introduction to the caching
+	This document gives a brief introduction to the caching
 mechanisms in the sunrpc layer that is used, in particular,
 for NFS authentication.
 
@@ -25,25 +25,17 @@ The common code handles such things as:
    - supporting 'NEGATIVE' as well as positive entries
    - allowing an EXPIRED time on cache items, and removing
      items after they expire, and are no longe in-use.
-
-   Future code extensions are expect to handle
    - making requests to user-space to fill in cache entries
    - allowing user-space to directly set entries in the cache
    - delaying RPC requests that depend on as-yet incomplete
      cache entries, and replaying those requests when the cache entry
      is complete.
-   - maintaining last-access times on cache entries
-   - clean out old entries when the caches become full
-
-The code for performing a cache lookup is also common, but in the form
-of a template.  i.e. a #define.
-Each cache defines a lookup function by using the DefineCacheLookup
-macro, or the simpler DefineSimpleCacheLookup macro
+   - clean out old entries as they expire.
 
 Creating a Cache
 ----------------
 
-1/ A cache needs a datum to cache.  This is in the form of a
+1/ A cache needs a datum to store.  This is in the form of a
    structure definition that must contain a
      struct cache_head
    as an element, usually the first.
@@ -51,35 +43,69 @@ Creating a Cache
    Each cache element is reference counted and contains
    expiry and update times for use in cache management.
 2/ A cache needs a "cache_detail" structure that
-   describes the cache.  This stores the hash table, and some
-   parameters for cache management.
-3/ A cache needs a lookup function.  This is created using
-   the DefineCacheLookup macro.  This lookup function is used both
-   to find entries and to update entries.  The normal mode for
-   updating an entry is to replace the old entry with a new
-   entry.  However it is possible to allow update-in-place
-   for those caches where it makes sense (no atomicity issues
-   or indirect reference counting issue)
-4/ A cache needs to be registered using cache_register().  This
-   includes in on a list of caches that will be regularly
-   cleaned to discard old data.  For this to work, some
-   thread must periodically call cache_clean
-   
+   describes the cache.  This stores the hash table, some
+   parameters for cache management, and some operations detailing how
+   to work with particular cache items.
+   The operations requires are:
+   	struct cache_head *alloc(void)
+		This simply allocates appropriate memory and returns
+   		a pointer to the cache_detail embedded within the
+		structure
+	void cache_put(struct kref *)
+		This is called when the last reference to an item is
+		is dropped.  The pointer passed is to the 'ref' field
+		in the cache_head.  cache_put should release any
+		references create by 'cache_init' and, if CACHE_VALID
+		is set, any references created by cache_update.
+		It should then release the memory allocated by
+   		'alloc'.
+        int match(struct cache_head *orig, struct cache_head *new)
+		test if the keys in the two structures match.  Return
+		1 if they do, 0 if they don't.
+	void init(struct cache_head *orig, struct cache_head *new)
+		Set the 'key' fields in 'new' from 'orig'.  This may
+		include taking references to shared objects.
+	void update(struct cache_head *orig, struct cache_head *new)
+		Set the 'content' fileds in 'new' from 'orig'.
+	int cache_show(struct seq_file *m, struct cache_detail *cd,
+			struct cache_head *h)
+		Optional.  Used to provide a /proc file that lists the
+		contents of a cache.  This should show one item,
+   		usually on just one line.
+	int cache_request(struct cache_detail *cd, struct cache_head *h,
+   		char **bpp, int *blen)
+		Format a request to be send to user-space for an item
+   		to be instantiated.  *bpp is a buffer of size *blen.
+		bpp should be moved forward over the encoded message,
+		and  *blen should be reduced to show how much free
+		space remains.  Return 0 on success or <0 if not
+		enough room or other problem.
+	int cache_parse(struct cache_detail *cd, char *buf, int len)
+		A message from user space has arrived to fill out a
+		cache entry.  It is in 'buf' of length 'len'.
+		cache_parse should parse this, find the item in the
+		cache with sunrpc_cache_lookup, and update the item
+		with sunrpc_cache_update.
+
+
+3/ A cache needs to be registered using cache_register().  This
+   includes it on a list of caches that will be regularly
+   cleaned to discard old data.
+
 Using a cache
 -------------
 
-To find a value in a cache, call the lookup function passing it a the
-datum which contains key, and possibly content, and a flag saying
-whether to update the cache with new data from the datum.   Depending
-on how the cache lookup function was defined, it may take an extra
-argument to identify the particular cache in question.
-
-Except in cases of kmalloc failure, the lookup function
-will return a new datum which will store the key and
-may contain valid content, or may not.
-This datum is typically passed to cache_check which determines the
-validity of the datum and may later initiate an upcall to fill
-in the data.
+To find a value in a cache, call sunrpc_cache_lookup passing a pointer
+to the cache_head in a sample item with the 'key' fields filled in.
+This will be passed to ->match to identify the target entry.  If no
+entry is found, a new entry will be create, added to the cache, and
+marked as not containing valid data.
+
+The item returned is typically passed to cache_check which will check
+if the data is valid, and may initiate an up-call to get fresh data.
+cache_check will return -ENOENT in the entry is negative or if an up
+call is needed but not possible, -EAGAIN if an upcall is pending,
+or 0 if the data is valid;
 
 cache_check can be passed a "struct cache_req *".  This structure is
 typically embedded in the actual request and can be used to create a
@@ -90,6 +116,13 @@ item does become valid, the deferred cop
 revisited (->revisit).  It is expected that this method will
 reschedule the request for processing.
 
+The value returned by sunrpc_cache_lookup can also be passed to
+sunrpc_cache_update to set the content for the item.  A second item is
+passed which should hold the content.  If the item found by _lookup
+has valid data, then it is discarded and a new item is created.  This
+saves any user of an item from worrying about content changing while
+it is being inspected.  If the item found by _lookup does not contain
+valid data, then the content is copied across and CACHE_VALID is set.
 
 Populating a cache
 ------------------
@@ -114,8 +147,8 @@ should be create or updated to have the 
 expiry time should be set on that item.
 
 Reading from a channel is a bit more interesting.  When a cache
-lookup fail, or when it suceeds but finds an entry that may soon
-expiry, a request is lodged for that cache item to be updated by
+lookup fails, or when it succeeds but finds an entry that may soon
+expire, a request is lodged for that cache item to be updated by
 user-space.  These requests appear in the channel file.
 
 Successive reads will return successive requests.
@@ -130,7 +163,7 @@ Thus a user-space helper is likely to:
     write a response
   loop.
 
-If it dies and needs to be restarted, any requests that have not be
+If it dies and needs to be restarted, any requests that have not been
 answered will still appear in the file and will be read by the new
 instance of the helper.
 
@@ -142,10 +175,9 @@ Each cache should also define a "cache_r
 takes a cache item and encodes a request into the buffer
 provided.
 
-
 Note: If a cache has no active readers on the channel, and has had not
 active readers for more than 60 seconds, further requests will not be
-added to the channel but instead all looks that do not find a valid
+added to the channel but instead all lookups that do not find a valid
 entry will fail.  This is partly for backward compatibility: The
 previous nfs exports table was deemed to be authoritative and a
 failed lookup meant a definite 'no'.
@@ -154,18 +186,17 @@ request/response format
 -----------------------
 
 While each cache is free to use it's own format for requests
-and responses over channel, the following is recommended are
+and responses over channel, the following is recommended as
 appropriate and support routines are available to help:
 Each request or response record should be printable ASCII
 with precisely one newline character which should be at the end.
 Fields within the record should be separated by spaces, normally one.
 If spaces, newlines, or nul characters are needed in a field they
-much be quotes.  two mechanisms are available:
+much be quoted.  two mechanisms are available:
 1/ If a field begins '\x' then it must contain an even number of
    hex digits, and pairs of these digits provide the bytes in the
    field.
 2/ otherwise a \ in the field must be followed by 3 octal digits
    which give the code for a byte.  Other characters are treated
-   as them selves.  At the very least, space, newlines nul, and
+   as them selves.  At the very least, space, newline, nul, and
    '\' must be quoted in this way.
-   
